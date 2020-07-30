import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> labelList, String wildcardString) {
  List<DropdownMenuItem<String>> items = new List();
  if(wildcardString != null && wildcardString.length != 0) {
    items.add(new DropdownMenuItem(
        value: "",
        child: new Text(wildcardString)
    ));      
  }
  for (String label in labelList) {
    items.add(new DropdownMenuItem(
        value: label,
        child: new Text(label)
    ));
  }
  return items;
}

void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
}

void launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true , forceWebView : true);
  } else {
    throw 'Could not launch $url';
  }
}