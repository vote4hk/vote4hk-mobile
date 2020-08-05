import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vote4hk_mobile/utils/color.dart';

class CaseTitle extends StatelessWidget {
  final String caseNo;
  final String status;
  final String localizedStatus;

  CaseTitle({this.caseNo, this.status, this.localizedStatus});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getColorFromStatus(this.status);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '#${this.caseNo} (${this.localizedStatus})',
          style: TextStyle(
              color: backgroundColor == WarsColors.greyLight
                  ? Colors.black
                  : Colors.white,
              fontSize: 14),
        ),
      ),
    );
  }
}

Color getColorFromStatus(String status) {
  switch (status) {
    case 'hospitalised':
    case 'stable':
      {
        return WarsColors.orange;
      }
    case 'hospitalised_again':
      {
        return Colors.orange[900];
      }
    case 'pending_admission':
      {
        return WarsColors.yellow;
      }
    case 'discharged':
      {
        return WarsColors.green;
      }
    case 'serious':
      {
        return Color(0xffeb605e);
      }
    case 'serious':
      {
        return WarsColors.red;
      }
    case 'deceased':
      {
        return WarsColors.grey;
      }
    case 'asymptomatic':
      {
        return WarsColors.blue;
      }
    default:
      {
        return WarsColors.greyLight;
      }
  }
}
