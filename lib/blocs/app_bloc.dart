import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vote4hk_mobile/api/api.dart';
import 'package:vote4hk_mobile/models/case.dart';


///
/// Use singleton instead of Provider
///
class AppBloc {
  static final AppBloc _instance = AppBloc();
  static AppBloc get instance => _instance;

  List<Case> _cases = new List();

  // final StreamController<int> _productCategoryRequestController =
  //     StreamController<int>();

  final _caseController = BehaviorSubject<List<Case>>();

  // output
  Stream<List<Case>> get cases => _caseController.stream;

  ///
  ///  Constructor
  ///
  AppBloc() {
    // TODO: fire the request and add data to stream?
    this._fetchCases();
  }

  void _fetchCases() async {
    List<Case> cases = await api.getCases();
    _cases = cases;
    _caseController.add(cases);
  }

  dispose() {
    _caseController.close();
  }
}
