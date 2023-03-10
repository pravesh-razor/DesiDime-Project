import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:desidime/models/popularmodel.dart';
import 'package:desidime/models/topmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static final client = http.Client();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future fetchTopDeals(var page) async {
    // var pref = await _prefs;
    try {
      var response = await client.get(
          Uri.parse(
              "http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=$page&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}"),
          headers: {
            'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'
          }).timeout(const Duration(seconds: 10));
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        // String top = jsonEncode(TopModel.fromJson(jsonBody));
        // pref.setString('top', top);
        return TopModel.fromJson(jsonBody);
      } else {
        Fluttertoast.showToast(msg: response.statusCode.toString());
        return TopModel.withError(
            '{"message": "Some Error Occured", "status": "false", "status_code": 0}');
      }
      //
    } on SocketException {
      Fluttertoast.showToast(msg: "Sorry, You don't have internet connection.");
    } on FormatException {
      Fluttertoast.showToast(msg: "Something went wrong in format");
    } on TimeoutException {
      Fluttertoast.showToast(msg: "Connection TimeOut");
      log("TimeOut Exception");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future fetchPopularDeals(var page) async {
    // var pref = await _prefs;
    try {
      var response = await client.get(
          Uri.parse(
              "http://stagingauth.desidime.com/v4/home/discussed?per_page=10&page=$page&fields=id,created_at,created_at_in_millis,image_medium,comments_count,store{name}"),
          headers: {
            'X-Desidime-Client': '08b4260e5585f282d1bd9d085e743fd9'
          }).timeout(const Duration(seconds: 10));
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        return PopularModel.fromJson(jsonBody);
      } else {
        Fluttertoast.showToast(msg: response.statusCode.toString());
        return TopModel.withError(
            '{"message": "Some Error Occured", "status": "false", "status_code": 0}');
      }
      //
    } on SocketException {
      Fluttertoast.showToast(msg: "Sorry, You don't have internet connection.");
    } on FormatException {
      Fluttertoast.showToast(msg: "Something went wrong in format");
    } on TimeoutException {
      Fluttertoast.showToast(msg: "Connection TimeOut");
      log("TimeOut Exception");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
