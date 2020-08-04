// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) {
  return UserLocation(
    addressEn: json['address_en'] as String,
    addressZh: json['address_zh'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'address_zh': instance.addressZh,
      'address_en': instance.addressEn,
      'lat': instance.lat,
      'lng': instance.lng,
    };
