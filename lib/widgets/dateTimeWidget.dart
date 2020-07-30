import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {
  final DateTime dateTime;
  final String label;
  double fontSize;
  DateTimeWidget(this.dateTime, this.fontSize, this.label);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    if(fontSize != null) {
      textStyle = TextStyle(fontSize: fontSize);
    }
    List<Widget> widgets = [];
    if(this.label != null && this.label.length > 1) {
      widgets.add(Text(this.label, style: textStyle));
    }
    widgets.add(Text(
          DateFormat('yyyy MMM dd').format(
                dateTime),
          style: textStyle));
    return Column(children: widgets);
  }
}


