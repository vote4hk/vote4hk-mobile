import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';
import 'package:vote4hk_mobile/models/patient_track.dart';

import 'case_group.dart';

part 'case.g.dart';

@JsonSerializable()
class Case {
  @JsonKey(name: 'case_no')
  String caseNo;

  @JsonKey(name: 'onset_date')
  String onSetDate;

  @JsonKey(name: 'confirmation_date')
  String confirmationDate;

  @JsonKey(name: 'gender')
  String gender;

  @JsonKey(name: 'age')
  String age;

  @JsonKey(name: 'hospital_zh')
  String hospitalZh;

  @JsonKey(name: 'hospital_en')
  String hospitalEn;

  String localizedHospital(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.hospitalEn
        : this.hospitalZh;
  }

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'status_zh')
  String statusZh;

  @JsonKey(name: 'status_en')
  String statusEn;

  String localizedStatus(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.statusEn : this.statusZh;
  }

  @JsonKey(name: 'type_zh')
  String typeZh;

  @JsonKey(name: 'type_en')
  String typeEn;

  String localizedType(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.typeEn : this.typeZh;
  }

  @JsonKey(name: 'citizenship_zh')
  String citizenshipZh;

  @JsonKey(name: 'citizenship_en')
  String citizenshipEn;

  String localizedCitizenship(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.citizenshipEn
        : this.citizenshipZh;
  }

  @JsonKey(name: 'citizenship_distrcit_zh')
  String citizenshipDistrictZh;

  @JsonKey(name: 'citizenship_district_en')
  String citizenshipDistrictEn;

  String localizedCitizenshipDistrict(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.citizenshipDistrictEn
        : this.citizenshipDistrictZh;
  }

  @JsonKey(name: 'detail_zh')
  String detailZh;

  @JsonKey(name: 'detail_en')
  String detailEn;

  String localizedDetail(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.detailEn : this.detailZh;
  }

  @JsonKey(name: 'classification_zh')
  String classificationZh;

  @JsonKey(name: 'classification_en')
  String classificationEn;

  String localizedClassification(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.classificationEn
        : this.classificationZh;
  }

  @JsonKey(name: 'source_url')
  String sourceUrl;

  @JsonKey(ignore: true)
  List<CaseGroup> caseGroups;

  @JsonKey(ignore: true)
  List<PatientTrack> patientTrack;

  Case({this.caseNo}) {
    this.caseGroups = [];
    this.patientTrack = [];
  }

  /// A necessary factory constructor for creating a new Model instance
  factory Case.fromJson(Map<String, dynamic> json) => _$CaseFromJson(json);

  Map<String, dynamic> toJson() => _$CaseToJson(this);
}
