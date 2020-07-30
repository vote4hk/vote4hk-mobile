import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const List<Color> MEMO_COLORS = [
  Color(0xffF28B83),
  Color(0xFFFCBC05),
  Color(0xFFFFF476),
  Color(0xFFCBFF90),
  Color(0xFFA7FEEA),
  Color(0xFFE6C9A9),
  Color(0xFFE8EAEE),
  Color(0xFFA7A7EA),
  Color(0xFFCAF0F8),
  Color(0xFFD0D0D0),
];


class MemoItem extends StatelessWidget {
  final String title;
  final Function tapWithTitle;
  final List<String> details;
  MemoItem (this.title, this.tapWithTitle, this.details);

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.06;
    if(fontSize > 40) {
      fontSize = 40;
    }
    double smallFontSize = fontSize/2;
    List<Widget> widgets = [Text(title, style: TextStyle(fontSize: fontSize))];
    details.forEach((element) {
      widgets.add(Row(children:[Text(element, style: TextStyle(fontSize: smallFontSize))]));
    });
    Widget rv = GestureDetector(
          onTap: () {tapWithTitle(title);},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: MEMO_COLORS[title.hashCode % MEMO_COLORS.length],
                border: Border.all(width: 1, color: Colors.grey),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    offset: new Offset(0.0, 2.5),
                    blurRadius: 4.0,
                    spreadRadius: 0.0
                  )
                ],
                //borderRadius: BorderRadius.circular(6.0)
                ),
              child: Column(
                children: widgets
              ),
            ),
          ),
        );
    return rv;
  }
}
