import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';

part 'case_location.g.dart';

@JsonSerializable()
class CaseLocation {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'case_no')
  String caseNo;

  @JsonKey(name: 'sub_district_zh')
  String subDistrictZh;

  @JsonKey(name: 'sub_district_en')
  String subDistrictEn;

  String localizedSubDistrict(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.subDistrictEn
        : this.subDistrictZh;
  }

  @JsonKey(name: 'source_url_1')
  String sourceUrl1;

  @JsonKey(name: 'source_url_2')
  String sourceUrl2;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'lat')
  String latString;

  @JsonKey(name: 'lng')
  String lngString;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'type_zh')
  String typeZh;

  @JsonKey(name: 'type_en')
  String typeEn;

  @JsonKey(name: 'remark_zh')
  String remarkZh;

  @JsonKey(name: 'remark_en')
  String remarkEn;

  String localizedRemark(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.remarkEn : this.remarkZh;
  }

  @JsonKey(name: 'action_zh')
  String actionZh;

  @JsonKey(name: 'action_en')
  String actionEn;

  String localizedAction(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.actionEn : this.actionZh;
  }

  @JsonKey(name: 'location_zh')
  String locationZh;

  @JsonKey(name: 'location_en')
  String locationEn;

  String localizedLocation(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.locationEn : this.locationZh;
  }

  CaseLocation({this.caseNo}) {}

  /// A necessary factory constructor for creating a new Model instance
  factory CaseLocation.fromJson(Map<String, dynamic> json) => _$CaseLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CaseLocationToJson(this);
}
