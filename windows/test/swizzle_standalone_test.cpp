// Standalone check for custom_platform_view/util/swizzle.h (no gtest, no Flutter needed).
//
//   cl /std:c++17 /EHsc /I. test\swizzle_standalone_test.cpp custom_platform_view\util\cpuid\cpuinfo.cc
//   swizzle_standalone_test.exe
//
// Deliberately built WITHOUT /arch:AVX2: that is how the plugin is now built, and each vector
// path must work through its own per-function instruction set.
#include <cstdio>
#include <cstdint>
#include <random>
#include <vector>

#include "custom_platform_view/util/swizzle.h"

namespace {

using Fn = void (*)(uint32_t*, const uint32_t*, int, int, int);

int Check(const char* name, Fn fn, int width, int height, int src_stride,
          int dst_stride, std::mt19937& rng) {
  std::vector<uint32_t> src(static_cast<size_t>(src_stride) * height);
  for (auto& v : src) v = rng();
  std::vector<uint32_t> want(static_cast<size_t>(dst_stride) * height, 0xABABABABu);
  std::vector<uint32_t> got = want;

  RGBA_to_BGRA_portable(want.data(), src.data(), height, src_stride, dst_stride);
  fn(got.data(), src.data(), height, src_stride, dst_stride);

  if (want != got) {
    std::printf("FAIL %s w=%d h=%d src_stride=%d dst_stride=%d\n", name, width,
                height, src_stride, dst_stride);
    return 1;
  }
  return 0;
}

}  // namespace

int main() {
  cpuid::cpuinfo info;
  std::mt19937 rng(12345);
  int failures = 0, runs = 0;

  struct Path { const char* name; Fn fn; bool ok; };
  const Path paths[] = {
      {"SSSE3", RGBA_to_BGRA_SSSE3, info.has_ssse3()},
      {"AVX2", RGBA_to_BGRA_AVX2, info.has_avx2()},
      {"AVX512", RGBA_to_BGRA_SKX,
       info.has_avx512_f() && info.has_avx512_dq() && info.has_avx512_cd() &&
           info.has_avx512_bw() && info.has_avx512_vl()},
  };

  for (const auto& p : paths) {
    if (!p.ok) {
      std::printf("skip %s (CPU lacks it)\n", p.name);
      continue;
    }
    // widths around every vector size boundary, strides larger than the width
    for (int w : {1, 2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 33, 64, 100, 1919, 1920}) {
      for (int h : {1, 3, 8}) {
        failures += Check(p.name, p.fn, w, h, w, w, rng);
        failures += Check(p.name, p.fn, w, h, w + 5, w + 5, rng);
        runs += 2;
      }
    }
    std::printf("ran %s\n", p.name);
  }

  // dispatcher itself, whichever path it picks
  for (int w : {1, 7, 16, 33, 1920}) {
    failures += Check("dispatch", RGBA_to_BGRA, w, 4, w, w, rng);
    ++runs;
  }

  std::printf("%d runs, %d failures\n", runs, failures);
  return failures == 0 ? 0 : 1;
}
