import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';

part 'patient_track.g.dart';

@JsonSerializable()
class PatientTrack {
  @JsonKey(name: 'case_no')
  String caseNo;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'location_zh')
  String locationZh;

  @JsonKey(name: 'location_en')
  String locationEn;

  String localizedLocation(BuildContext context) {
    return AppLanguage.isContextEng(context)
        ? this.locationEn
        : this.locationZh;
  }

  @JsonKey(name: 'action_zh')
  String actionZh;

  @JsonKey(name: 'action_en')
  String actionEn;

  String localizedAction(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.actionEn : this.actionZh;
  }

  @JsonKey(name: 'remarks_zh')
  String remarksZh;

  @JsonKey(name: 'remarks_en')
  String remarksEn;

  String localizedremarks(BuildContext context) {
    return AppLanguage.isContextEng(context) ? this.remarksEn : this.remarksZh;
  }

  @JsonKey(name: 'source_url_1')
  String sourceUrl1;

  @JsonKey(name: 'source_url_2')
  String sourceUrl2;

  PatientTrack();

  /// A necessary factory constructor for creating a new Model instance
  factory PatientTrack.fromJson(Map<String, dynamic> json) =>
      _$PatientTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PatientTrackToJson(this);
}
