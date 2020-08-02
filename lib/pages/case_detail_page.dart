import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote4hk_mobile/blocs/app_bloc.dart';
import 'package:vote4hk_mobile/i18n/app_language.dart';
import 'package:vote4hk_mobile/i18n/app_localizations.dart';
import 'package:vote4hk_mobile/models/case.dart';
import 'package:vote4hk_mobile/widgets/stateless/case_card.dart';

class CreateDetailPageParam {
  String caseNo;

  CreateDetailPageParam({this.caseNo});
}

class CaseDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage>
    with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appLang = Provider.of<AppLanguage>(context);
    CreateDetailPageParam param =
        ModalRoute.of(context).settings.arguments as CreateDetailPageParam;

    var caseNo = null;
    if (param != null && param.caseNo != '') {
      caseNo = param.caseNo;
    }

    return Stack(
      children: <Widget>[
        Scaffold(
            // TODO: extract to shared instance
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).get('site.title')),
            ),
            body: StreamBuilder<List<Case>>(
              stream: AppBloc.instance.cases,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<Case> cases = snapshot.data;
                if (cases == null || cases.length == 0 || caseNo == null) {
                  return Text('Case not found :(');
                }

                Case c = cases.where((_c) => _c.caseNo == caseNo).first;

                if (c == null) {
                  return Text('Case not found :(');
                }

                return CaseCard(data: c);
              },
            )),
      ],
    );
  }
}
