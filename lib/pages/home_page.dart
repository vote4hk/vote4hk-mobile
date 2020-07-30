import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vote4hk_mobile/blocs/app_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _fadeController;
  Animation _fadeAnimation;
  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_fadeController);

    _fadeController.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("vote4hk"),              
            ),
            body: StreamBuilder(
              stream: AppBloc.instance.cases,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Stack(
                  children: [                    
                  ],
                );
              },
            )),
        AnimatedBuilder(
          animation: _fadeController,
          builder: (context, child) => _fadeAnimation.value > 0
              ? Container(
                  width: 3000.0,
                  height: 3000.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .buttonColor
                          .withAlpha((255 * _fadeAnimation.value).round())),
                )
              : SizedBox(),
        )
      ],
    );
  }
}
