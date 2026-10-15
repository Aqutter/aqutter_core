package com.github.aqutter.core

interface ISettings<T> {
  fun parse(settings: MutableMap<String, Any?>): ISettings<T>
  fun toMap(): MutableMap<String, Any?>
  fun getRealSettings(obj: T): MutableMap<String, Any?>
}
