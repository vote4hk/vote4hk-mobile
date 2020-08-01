// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientTrack _$PatientTrackFromJson(Map<String, dynamic> json) {
  return PatientTrack()
    ..caseNo = json['case_no'] as String
    ..startDate = json['start_date'] as String
    ..endDate = json['end_date'] as String
    ..locationZh = json['location_zh'] as String
    ..locationEn = json['location_en'] as String
    ..actionZh = json['action_zh'] as String
    ..actionEn = json['action_en'] as String
    ..remarksZh = json['remarks_zh'] as String
    ..remarksEn = json['remarks_en'] as String
    ..sourceUrl1 = json['source_url_1'] as String
    ..sourceUrl2 = json['source_url_2'] as String;
}

Map<String, dynamic> _$PatientTrackToJson(PatientTrack instance) =>
    <String, dynamic>{
      'case_no': instance.caseNo,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'location_zh': instance.locationZh,
      'location_en': instance.locationEn,
      'action_zh': instance.actionZh,
      'action_en': instance.actionEn,
      'remarks_zh': instance.remarksZh,
      'remarks_en': instance.remarksEn,
      'source_url_1': instance.sourceUrl1,
      'source_url_2': instance.sourceUrl2,
    };
