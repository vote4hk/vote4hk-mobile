import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';

part 'user_location.g.dart';

@JsonSerializable()
class UserLocation {

  @JsonKey(name: 'address_zh')
  String addressZh;

  @JsonKey(name: 'address_en')
  String addressEn;

  String localizedAddress(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.addressEn : this.addressZh;
  }

  @JsonKey(name: 'lat')
  double lat;

  @JsonKey(name: 'lng')
  double lng;
  UserLocation({
    this.addressEn,
    this.addressZh,
    this.lat,
    this.lng,
  });

  /// A necessary factory constructor for creating a new Model instance
  factory UserLocation.fromJson(Map<String, dynamic> json) => _$UserLocationFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
