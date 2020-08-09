import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:vote4hk_mobile/models/case.dart';
import 'package:vote4hk_mobile/models/case_group.dart';
import 'package:vote4hk_mobile/models/case_location.dart';
import 'package:vote4hk_mobile/models/patient_track.dart';

import 'exceptions.dart';

Vote4HKApi api = Vote4HKApi();

class Vote4HKApi {
  final _httpClient = new HttpClient();
  final _client = Client();
  String _token;

  // setter
  set token(String t) {
    _token = t;
  }

  Future<List<Case>> getCases() async {
    var uri = _endPoint('page-data/cases/page-data.json');

    Map data = await _getRequest(uri);
    List<Case> cases = data['result']['data']['allWarsCase']['edges']
            .map<Case>((json) => Case.fromJson(json['node']))
            .toList() ??
        new List();

    // add the information associated
    List<CaseGroup> groups = data['result']['data']['allWarsCaseRelation']
                ['edges']
            .map<CaseGroup>((json) => CaseGroup.fromJson(json['node']))
            .toList() ??
        new List();

    List<PatientTrack> tracks = [];
    data['result']['data']['patient_track']['group'].forEach((g) => {
      g['edges'].forEach((pt) => {
        tracks.add(PatientTrack.fromJson(pt['node']))
      })
    });                

    Map<String, Case> map = new Map();
    cases.forEach((c) {
      map[c.caseNo] = c;
    });

    groups.forEach((g) {
      g.getCaseNos().forEach((caseNo) {
        if (map[caseNo] != null) {
          map[caseNo].caseGroups.add(g);
        }
      });
    });

    tracks.forEach((t) {
      if (map[t.caseNo] != null) {
        map[t.caseNo].patientTrack.add(t);
      }
    });

    return cases;
  }


  Future<List<CaseLocation>> getCaseLocations() async {
    var uri = _endPoint('page-data/high-risk/page-data.json');

    Map data = await _getRequest(uri);
    List<CaseLocation> locations = data['result']['data']['allWarsCaseLocation']['edges']
            .map<CaseLocation>((json) => CaseLocation.fromJson(json['node']))
            .toList() ??
        new List();

   

    return locations;
  }

  Future<List<dynamic>> searchLocation(String address, String lang) async {
    var uri = _searchEndPoint('search', {
      'address': address,
      'lang': lang
    });
    Map data = await _getRequest(uri);
    return data['data']['results'];
  }

  ///
  ///     ====================  Helper methods  =========================
  ///
  ///

  Uri _endPoint(path, [Map<String, String> queryParameters]) {
    // TODO: move the env vars
    return Uri.https('wars.vote4.hk', path, queryParameters);
  }

  Uri _searchEndPoint(path, [Map<String, String> queryParameters]) {
    // TODO: move the env vars
    return Uri.https('addressparserapi-5f067.asia1.kinto.io', path, queryParameters);
  }

  Future<Map> _putRequest(Uri uri, Map jsonMap) async {
    var request = await _httpClient.putUrl(uri);
    request.headers.set('content-type', 'application/json');
    if (_token != null) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + _token);
    }

    request.add(utf8.encode(json.encode(jsonMap)));
    var response = await request.close();
    final data = json.decode(await response.transform(utf8.decoder).join());
    if (response.statusCode == 200) {
      return data;
    }
    // Try to parse the error first
    throw new APIException(data);
  }

  Future<Map> _postRequest(Uri uri, Map jsonMap) async {
    var request = await _httpClient.postUrl(uri);
    request.headers.set('content-type', 'application/json');
    if (_token != null) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + _token);
    }

    request.add(utf8.encode(json.encode(jsonMap)));
    var response = await request.close();
    final data = json.decode(await response.transform(utf8.decoder).join());
    if (response.statusCode == 200) {
      return data;
    }
    // Try to parse the error first
    throw new APIException(data);
  }

  Future<Map> _getRequest(Uri uri) async {
    var request = await _httpClient.getUrl(uri);
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    if (_token != null) {
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer ' + _token);
    }

    var response = await request.close();
    final data = json.decode(await response.transform(utf8.decoder).join());
    if (response.statusCode == 200) {
      return data;
    }
    // Try to parse the error first
    throw new APIException(data);
  }

  Future<Map> _multipartRequest(Uri uri, File file) async {
    var request = MultipartRequest("POST", uri);
    var fileStream = ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    request.headers.addAll({'Authorization': 'Bearer ' + _token});
    request.fields['test'] = 'data';
    request.files.add(MultipartFile('file', fileStream, length,
        filename: basename(file.path)));

    var response = await _client.send(request);
    var string = await response.stream.transform(utf8.decoder).join();
    final data = json.decode(string);
    if (response.statusCode == 200) {
      return data;
    }
    // Try to parse the error first
    throw new APIException(data);
  }

  ///
  /// Return null if there is no error. otherise return the error message
  ///
  String getError(jsonData) {
    if (jsonData['statusCode'] != null && jsonData['statusCode'] != 200) {
      return jsonData['message'];
    }

    return null;
  }
}
