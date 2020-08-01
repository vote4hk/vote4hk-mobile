// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Case _$CaseFromJson(Map<String, dynamic> json) {
  return Case(
    caseNo: json['case_no'] as String,
  )
    ..onSetDate = json['onset_date'] as String
    ..confirmationDate = json['confirmation_date'] as String
    ..gender = json['gender'] as String
    ..age = json['age'] as String
    ..hospitalZh = json['hospital_zh'] as String
    ..hospitalEn = json['hospital_en'] as String
    ..status = json['status'] as String
    ..statusZh = json['status_zh'] as String
    ..statusEn = json['status_en'] as String
    ..typeZh = json['type_zh'] as String
    ..typeEn = json['type_en'] as String
    ..citizenshipZh = json['citizenship_zh'] as String
    ..citizenshipEn = json['citizenship_en'] as String
    ..citizenshipDistrictZh = json['citizenship_distrcit_zh'] as String
    ..citizenshipDistrictEn = json['citizenship_district_en'] as String
    ..detailZh = json['detail_zh'] as String
    ..detailEn = json['detail_en'] as String
    ..classificationZh = json['classification_zh'] as String
    ..classificationEn = json['classification_en'] as String
    ..sourceUrl = json['source_url'] as String;
}

Map<String, dynamic> _$CaseToJson(Case instance) => <String, dynamic>{
      'case_no': instance.caseNo,
      'onset_date': instance.onSetDate,
      'confirmation_date': instance.confirmationDate,
      'gender': instance.gender,
      'age': instance.age,
      'hospital_zh': instance.hospitalZh,
      'hospital_en': instance.hospitalEn,
      'status': instance.status,
      'status_zh': instance.statusZh,
      'status_en': instance.statusEn,
      'type_zh': instance.typeZh,
      'type_en': instance.typeEn,
      'citizenship_zh': instance.citizenshipZh,
      'citizenship_en': instance.citizenshipEn,
      'citizenship_distrcit_zh': instance.citizenshipDistrictZh,
      'citizenship_district_en': instance.citizenshipDistrictEn,
      'detail_zh': instance.detailZh,
      'detail_en': instance.detailEn,
      'classification_zh': instance.classificationZh,
      'classification_en': instance.classificationEn,
      'source_url': instance.sourceUrl,
    };
