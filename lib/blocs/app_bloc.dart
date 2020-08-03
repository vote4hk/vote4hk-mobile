import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vote4hk_mobile/api/api.dart';
import 'package:vote4hk_mobile/models/case.dart';
import 'package:vote4hk_mobile/models/case_location.dart';

enum AppActionType {
  GET_CASE,
  GET_CASE_LOCATIONS,
}

class AppAction {
  AppActionType type;
  dynamic data;
}

///
/// Use singleton instead of Provider
///
class AppBloc {
  static final AppBloc _instance = AppBloc();
  static AppBloc get instance => _instance;

  List<Case> _cases = new List();

  final StreamController<AppAction> _appActionController =
      StreamController<AppAction>();

  final _casesController = BehaviorSubject<List<Case>>();
  
  // stream for search a single case
  final _caseDetailController = BehaviorSubject<Case>();

  // output
  Stream<List<Case>> get cases => _casesController.stream;
  
  Stream<Case> get caseDetail => _caseDetailController.stream;

  ///
  ///  Constructor
  ///
  AppBloc() {
    // TODO: fire the request and add data to stream?
    this._fetchCases();
    _appActionController.stream.listen(_handleAppAction);
  }

  void _fetchCases() async {
    List<Case> cases = await api.getCases();
    _cases = cases;
    _casesController.add(cases);
  }


  void _handleAppAction(AppAction action) async {
    switch (action.type) {
      case AppActionType.GET_CASE:
        {
          Case cachedCase = _cases.where((c) => c.caseNo == action.data).first;
          // this is nullable
          _caseDetailController.add(cachedCase);
          break;
        }
      case AppActionType.GET_CASE_LOCATIONS:
        {
          // TODO:
        }
    }
  }

  dispose() {
    _casesController.close();
    _caseDetailController.close();
    _appActionController.close();
  }
}
