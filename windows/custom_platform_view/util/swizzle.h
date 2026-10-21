/*
 * Copyright 2016 Google Inc.
 *
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

/*
 * see skia/src/opts/SkSwizzler_opts.h
 */

#pragma once

#include <algorithm>
#include <cstdint>

#include "cpuid/cpuinfo.h"

// The vector paths are chosen at runtime from cpuid, so the plugin itself must NOT be compiled
// with /arch:AVX2 (that would let the compiler emit AVX2 anywhere and crash on older CPUs before
// the runtime check is ever reached). Each vector function opts in to its own instruction set
// instead: MSVC accepts any intrinsic regardless of /arch, GCC/Clang need a per-function target.
#if defined(_M_X64) || defined(_M_IX86) || defined(__x86_64__) || defined(__i386__)
#define AQUTTER_SWIZZLE_X86 1
#include <immintrin.h>
#else
#define AQUTTER_SWIZZLE_X86 0
#endif

#if defined(_MSC_VER) && !defined(__clang__)
#define AQUTTER_TARGET(x)
#else
#define AQUTTER_TARGET(x) __attribute__((target(x)))
#endif

inline void RGBA_to_BGRA_portable(uint32_t* dst, const uint32_t* src,
                                  int height, int src_stride, int dst_stride) {
  auto width = std::min<int>(src_stride, dst_stride);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      uint8_t a = (src[x] >> 24) & 0xFF, b = (src[x] >> 16) & 0xFF,
              g = (src[x] >> 8) & 0xFF, r = (src[x] >> 0) & 0xFF;
      dst[x] = (uint32_t)a << 24 | (uint32_t)r << 16 | (uint32_t)g << 8 |
               (uint32_t)b << 0;
    }

    src += src_stride;
    dst += dst_stride;
  }
}

#if AQUTTER_SWIZZLE_X86

AQUTTER_TARGET("avx512f,avx512bw,avx512vl,avx512dq,avx512cd")
inline void RGBA_to_BGRA_SKX(uint32_t* dst, const uint32_t* src, int height,
                             int src_stride, int dst_stride) {
  const uint8_t mask[64] = {2,  1,  0,  3,  6,  5,  4,  7,  10, 9,  8,  11, 14,
                            13, 12, 15, 2,  1,  0,  3,  6,  5,  4,  7,  10, 9,
                            8,  11, 14, 13, 12, 15, 2,  1,  0,  3,  6,  5,  4,
                            7,  10, 9,  8,  11, 14, 13, 12, 15, 2,  1,  0,  3,
                            6,  5,  4,  7,  10, 9,  8,  11, 14, 13, 12, 15};
  const __m512i swapRB = _mm512_loadu_si512(mask);

  auto width = std::min<int>(src_stride, dst_stride);

  for (int y = 0; y < height; y++) {
    auto cw = width;
    auto rptr = src;
    auto dptr = dst;
    while (cw >= 16) {
      __m512i rgba = _mm512_loadu_si512((const __m512i*)rptr);
      __m512i bgra = _mm512_shuffle_epi8(rgba, swapRB);
      _mm512_storeu_si512((__m512i*)dptr, bgra);

      rptr += 16;
      dptr += 16;
      cw -= 16;
    }

    for (auto x = 0; x < cw; x++) {
      uint8_t a = (rptr[x] >> 24) & 0xFF, b = (rptr[x] >> 16) & 0xFF,
              g = (rptr[x] >> 8) & 0xFF, r = (rptr[x] >> 0) & 0xFF;
      dptr[x] = (uint32_t)a << 24 | (uint32_t)r << 16 | (uint32_t)g << 8 |
                (uint32_t)b << 0;
    }

    src += src_stride;
    dst += dst_stride;
  }
}

#endif

#if AQUTTER_SWIZZLE_X86

AQUTTER_TARGET("ssse3")
inline void RGBA_to_BGRA_SSSE3(uint32_t* dst, const uint32_t* src, int height,
                               int src_stride, int dst_stride) {
  const __m128i swapRB =
      _mm_setr_epi8(2, 1, 0, 3, 6, 5, 4, 7, 10, 9, 8, 11, 14, 13, 12, 15);

  auto width = std::min<int>(src_stride, dst_stride);

  for (int y = 0; y < height; y++) {
    auto cw = width;
    auto rptr = src;
    auto dptr = dst;
    while (cw >= 4) {
      __m128i rgba = _mm_loadu_si128((const __m128i*)rptr);
      __m128i bgra = _mm_shuffle_epi8(rgba, swapRB);
      _mm_storeu_si128((__m128i*)dptr, bgra);

      rptr += 4;
      dptr += 4;
      cw -= 4;
    }

    for (auto x = 0; x < cw; x++) {
      uint8_t a = (rptr[x] >> 24) & 0xFF, b = (rptr[x] >> 16) & 0xFF,
              g = (rptr[x] >> 8) & 0xFF, r = (rptr[x] >> 0) & 0xFF;
      dptr[x] = (uint32_t)a << 24 | (uint32_t)r << 16 | (uint32_t)g << 8 |
                (uint32_t)b << 0;
    }

    src += src_stride;
    dst += dst_stride;
  }
}

AQUTTER_TARGET("avx2")
inline void RGBA_to_BGRA_AVX2(uint32_t* dst, const uint32_t* src, int height,
                              int src_stride, int dst_stride) {
  const __m256i swapRB =
      _mm256_setr_epi8(2, 1, 0, 3, 6, 5, 4, 7, 10, 9, 8, 11, 14, 13, 12, 15, 2,
                       1, 0, 3, 6, 5, 4, 7, 10, 9, 8, 11, 14, 13, 12, 15);

  auto width = std::min<int>(src_stride, dst_stride);

  for (int y = 0; y < height; y++) {
    auto cw = width;
    auto rptr = src;
    auto dptr = dst;
    while (cw >= 8) {
      __m256i rgba = _mm256_loadu_si256((const __m256i*)rptr);
      __m256i bgra = _mm256_shuffle_epi8(rgba, swapRB);
      _mm256_storeu_si256((__m256i*)dptr, bgra);

      rptr += 8;
      dptr += 8;
      cw -= 8;
    }

    for (auto x = 0; x < cw; x++) {
      uint8_t a = (rptr[x] >> 24) & 0xFF, b = (rptr[x] >> 16) & 0xFF,
              g = (rptr[x] >> 8) & 0xFF, r = (rptr[x] >> 0) & 0xFF;
      dptr[x] = (uint32_t)a << 24 | (uint32_t)r << 16 | (uint32_t)g << 8 |
                (uint32_t)b << 0;
    }

    src += src_stride;
    dst += dst_stride;
  }
}

#endif

inline void RGBA_to_BGRA(uint32_t* dst, const uint32_t* src, int height,
                         int src_stride, int dst_stride) {
#if AQUTTER_SWIZZLE_X86
  static cpuid::cpuinfo info;

  if (info.has_avx512_f() && info.has_avx512_dq() && info.has_avx512_cd() &&
      info.has_avx512_bw() && info.has_avx512_vl()) {
    return RGBA_to_BGRA_SKX(dst, src, height, src_stride, dst_stride);
  }

  if (info.has_avx2()) {
    return RGBA_to_BGRA_AVX2(dst, src, height, src_stride, dst_stride);
  }

  if (info.has_ssse3()) {
    return RGBA_to_BGRA_SSSE3(dst, src, height, src_stride, dst_stride);
  }
#endif

  RGBA_to_BGRA_portable(dst, src, height, src_stride, dst_stride);
}
