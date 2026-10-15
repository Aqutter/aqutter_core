// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_resource.dart';

// **************************************************************************
// ExchangeableObjectGenerator
// **************************************************************************

///Class that represents an Android resource file.
class AqutterAndroidResource {
  ///Optional default package to find, if "package:" is not included in the name.
  ///Can be `null` to require an explicit package.
  ///
  ///Example: "android" if you want use resources from `android.R.`
  String? defPackage;

  ///Optional default resource type to find, if "type/" is not included in the name.
  ///Can be `null` to require an explicit type.
  ///
  ///Example: "anim"
  String? defType;

  ///Android resource name.
  ///
  ///A list of available `android.R.drawable` can be found
  ///[here](https://developer.android.com/reference/android/R.drawable).
  ///
  ///A list of available `android.R.anim` can be found
  ///[here](https://developer.android.com/reference/android/R.anim).
  ///
  ///A list of available `androidx.appcompat.R.anim` can be found
  ///[here](https://android.googlesource.com/platform/frameworks/support/+/HEAD/appcompat/appcompat/src/main/res/anim/)
  ///(abc_*.xml files).
  ///In this case, [defPackage] must match your App Android package name.
  String name;
  AqutterAndroidResource({this.defPackage, this.defType, required this.name});

  ///Gets a possible [AqutterAndroidResource] instance from a [Map] value.
  static AqutterAndroidResource? fromMap(
    Map<String, dynamic>? map, {
    AqutterEnumMethod? enumMethod,
  }) {
    if (map == null) {
      return null;
    }
    final instance = AqutterAndroidResource(
      defPackage: map['defPackage'],
      defType: map['defType'],
      name: map['name'],
    );
    return instance;
  }

  static AqutterAndroidResource anim({
    required String name,
    String? defPackage,
  }) {
    return AqutterAndroidResource(
      name: name,
      defType: "anim",
      defPackage: defPackage,
    );
  }

  static AqutterAndroidResource layout({
    required String name,
    String? defPackage,
  }) {
    return AqutterAndroidResource(
      name: name,
      defType: "layout",
      defPackage: defPackage,
    );
  }

  static AqutterAndroidResource id({required String name, String? defPackage}) {
    return AqutterAndroidResource(
      name: name,
      defType: "id",
      defPackage: defPackage,
    );
  }

  static AqutterAndroidResource drawable({
    required String name,
    String? defPackage,
  }) {
    return AqutterAndroidResource(
      name: name,
      defType: "drawable",
      defPackage: defPackage,
    );
  }

  ///Converts instance to a map.
  Map<String, dynamic> toMap({AqutterEnumMethod? enumMethod}) {
    return {"defPackage": defPackage, "defType": defType, "name": name};
  }

  ///Converts instance to a map.
  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'AqutterAndroidResource{defPackage: $defPackage, defType: $defType, name: $name}';
  }
}
