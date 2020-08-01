import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';

part 'case_group.g.dart';

@JsonSerializable()
class CaseGroup {

  @JsonKey(name: 'case_no')
  String caseNo;

  List<String> getCaseNos() {
    return this.caseNo.split(',') ?? [];
  }

  @JsonKey(name: 'name_zh')
  String nameZh;

  @JsonKey(name: 'name_en')
  String nameEn;

  String localizedName(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.nameEn : this.nameZh;
  }

  @JsonKey(name: 'description_zh')
  String descZh;

  @JsonKey(name: 'description_en')
  String descEn;

  String localizedDesc(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.descEn : this.descZh;
  }

  CaseGroup();

  /// A necessary factory constructor for creating a new Model instance
  factory CaseGroup.fromJson(Map<String, dynamic> json) => _$CaseGroupFromJson(json);

  Map<String, dynamic> toJson() => _$CaseGroupToJson(this);
}
