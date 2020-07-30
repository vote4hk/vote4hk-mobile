import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Case {
  
  @JsonKey(name: 'case_no')
  String caseNo;

}