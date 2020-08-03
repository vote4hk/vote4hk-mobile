// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseLocation _$CaseLocationFromJson(Map<String, dynamic> json) {
  return CaseLocation(
    caseNo: json['case_no'] as String,
  )
    ..id = json['id'] as String
    ..subDistrictZh = json['sub_district_zh'] as String
    ..subDistrictEn = json['sub_district_en'] as String
    ..sourceUrl1 = json['source_url_1'] as String
    ..sourceUrl2 = json['source_url_2'] as String
    ..startDate = json['start_date'] as String
    ..endDate = json['end_date'] as String
    ..latString = json['lat'] as String
    ..lngString = json['lng'] as String
    ..type = json['type'] as String
    ..typeZh = json['type_zh'] as String
    ..typeEn = json['type_en'] as String
    ..remarkZh = json['remark_zh'] as String
    ..remarkEn = json['remark_en'] as String
    ..actionZh = json['action_zh'] as String
    ..actionEn = json['action_en'] as String
    ..locationZh = json['location_zh'] as String
    ..locationEn = json['location_en'] as String;
}

Map<String, dynamic> _$CaseLocationToJson(CaseLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'case_no': instance.caseNo,
      'sub_district_zh': instance.subDistrictZh,
      'sub_district_en': instance.subDistrictEn,
      'source_url_1': instance.sourceUrl1,
      'source_url_2': instance.sourceUrl2,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'lat': instance.latString,
      'lng': instance.lngString,
      'type': instance.type,
      'type_zh': instance.typeZh,
      'type_en': instance.typeEn,
      'remark_zh': instance.remarkZh,
      'remark_en': instance.remarkEn,
      'action_zh': instance.actionZh,
      'action_en': instance.actionEn,
      'location_zh': instance.locationZh,
      'location_en': instance.locationEn,
    };
