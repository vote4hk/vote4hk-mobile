import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseTitle extends StatelessWidget {
  final String caseNo;
  final String status;
  final String localizedStatus;

  CaseTitle({this.caseNo, this.status, this.localizedStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: getColorFromStatus(this.status),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('#${this.caseNo} (${this.localizedStatus})', style: TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }
}

Color getColorFromStatus(String status) {
  switch (status) {
    case 'hospitalised':
    case 'stable':
      {
        return Colors.amber[900];
      }
    case 'hospitalised_again':
      {
        return Colors.orange[900];
      }
    case 'pending_admission':
      {
        return Color(0xfff99f02);
      }
    case 'discharged':
      {
        return Color(0xff368e3b);
      }
    case 'serious':
      {
        return Color(0xffeb605e);
      }
    case 'serious':
      {
        return Colors.red[900];
      }
    case 'deceased':
      {
        return Colors.grey[700];
      }
    case 'asymptomatic':
      {
        return Color(0xff4f5096);
      }
    default:
      {
        return Color(0xffcfcfcf);
      }
  }
}
