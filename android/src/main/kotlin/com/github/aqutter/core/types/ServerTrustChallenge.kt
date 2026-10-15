package com.github.aqutter.core.types

class ServerTrustChallenge(protectionSpace: URLProtectionSpace) : URLAuthenticationChallenge(protectionSpace) {
  override fun toString(): String {
    return "ServerTrustChallenge{} " + super.toString()
  }
}
