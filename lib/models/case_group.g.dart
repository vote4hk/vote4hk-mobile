// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseGroup _$CaseGroupFromJson(Map<String, dynamic> json) {
  return CaseGroup()
    ..caseNo = json['case_no'] as String
    ..nameZh = json['name_zh'] as String
    ..nameEn = json['name_en'] as String
    ..descZh = json['description_zh'] as String
    ..descEn = json['description_en'] as String;
}

Map<String, dynamic> _$CaseGroupToJson(CaseGroup instance) => <String, dynamic>{
      'case_no': instance.caseNo,
      'name_zh': instance.nameZh,
      'name_en': instance.nameEn,
      'description_zh': instance.descZh,
      'description_en': instance.descEn,
    };
