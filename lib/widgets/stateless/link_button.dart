import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final String url;

  LinkButton({this.text, this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => {
        if (await canLaunch(url)) {
          await launch(url)
        } else {
          throw 'Could not launch $url'
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor)),
        padding: EdgeInsets.all(4.0),
        child:
            Text(text, style: TextStyle(color: Theme.of(context).accentColor)),
      ),
    );
  }
}
