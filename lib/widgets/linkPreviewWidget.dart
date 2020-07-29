import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/openGraphParser.dart';

class LinkPreview extends StatefulWidget {
  LinkPreview(
      {this.link,
      this.launchFromLink,
      this.hideLink});

  final String link;
  final bool launchFromLink;
  final bool hideLink;

  @override
  LinkPreviewView createState() => LinkPreviewView();
}

// RichLinkPreviewView

class LinkPreviewView extends LinkPreviewModel {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [Container(child: buildLinkPreview(context))]));
  }
}

// RichLinkPreviewMode 
abstract class LinkPreviewModel extends State<LinkPreview>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> position;
  Image previewImage;
  String _link;
  bool _isLink;
  bool _launchFromLink;
  Map _ogData;

  void getOGData() async {
    OpenGraphParser.getOpenGraphData(_link).then((Map data) {
      if (data != null) {
        if (this.mounted && data['title'] != null) {
          setState(() {
            _ogData = data;
          });

          controller = AnimationController(
              vsync: this, duration: Duration(milliseconds: 750));
          position = Tween<Offset>(begin: Offset(0.0, 4.0), end: Offset.zero)
              .animate(
                  CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

          controller.forward();
        }
      } else {
        setState(() {
          _ogData = null;
        });
      }
    });
  }

  @override
  void initState() {
    _isLink = false;
    _link = widget.link ?? '';
    _launchFromLink = widget.launchFromLink ?? true;
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isValidUrl(link) {
    String regexSource =
        "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]";
    final regex = RegExp(regexSource);
    final matches = regex.allMatches(link);
    for (Match match in matches) {
      if (match.start == 0 && match.end == link.length) {
        return true;
      }
    }
    return false;
  }

  @override
  void didUpdateWidget(LinkPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.link != widget.link) {
      _fetchData();
    }
    /*
    if (this.mounted && _appendToLink == false) {
      setState(() {
        _link = oldWidget.link != widget.link ? widget.link : '';
      });
    }
    _fetchData();
    */
  }

  void _fetchData() {
    if (isValidUrl(_link) == true) {
      getOGData();
      _isLink = true;
    } else {
      if (this.mounted) {
        setState(() {
          _ogData = null;
        });
      }
      _isLink = false;
    }
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildLinkPreview(BuildContext context) {
    if (_ogData == null) {
      return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 8, child: _buildUrl(context)),
          ]);
    } else {
      //if (_appendToLink == true) {
        return _buildWrappedInkWell(_buildPreviewRow(context));
    }
  }

  Widget _buildRichLinkPreviewBody(BuildContext context, Map _ogData) {
    return Container(
        padding: const EdgeInsets.all(3.0),
//        height: _height,
        decoration: BoxDecoration(
          //color: _backgroundColor,
        ),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTitle(context),
              _buildDescription(context),
            ]));
  }

  Widget _buildPreviewRow(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if(width > height) {
      width = height;
    }
    if (_ogData['image'] != null) {
      return Column(
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        child: new ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(3.0),
                            ),
                            child: Image.network(_ogData['image'],
                                width: width/4,
                                fit: BoxFit.fill)))
                  ],
                )),
            Expanded(
                flex: 5, child: _buildRichLinkPreviewBody(context, _ogData)),
          ]),
          widget.hideLink ? Container() :Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Expanded(flex: 8, child: _buildUrl(context)),
          ])
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildRichLinkPreviewBody(context, _ogData)],
      );
    }
  }

  Widget _buildTitle(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    if(fontSize > 40) {
      fontSize = 40;
    }
    double smallFontSize = fontSize/2;
    if (_ogData != null && _ogData['title'] != null) {
      return Padding(
          padding: EdgeInsets.all(1.0),
          child: new Text(
            _ogData['title'],
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ));
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  Widget _buildDescription(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.03;
    if(fontSize > 40) {
      fontSize = 40;
    }
    if (_ogData != null && _ogData['description'] != null) {
      return Padding(
          padding: EdgeInsets.all(2.0),
          child: new Text(_ogData['description'],
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: fontSize)));
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  Widget _buildUrl(BuildContext context) {
    if (_link != '') {
      return _buildWrappedInkWell( Container(
          decoration: BoxDecoration(
            //color: _backgroundColor,
          ),
          child: Padding(
              padding: EdgeInsets.all(5.0),
              child: new Text(_link,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  /*style: TextStyle(color: _textColor) */))));
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }

  Widget _buildWrappedInkWell(Widget widget) {
    if (_launchFromLink == true &&
        _link != '' &&
        _isLink == true) {
      return InkWell(child: widget, onTap: () => _launchURL(_link));
    }
    return widget;
  }
}
