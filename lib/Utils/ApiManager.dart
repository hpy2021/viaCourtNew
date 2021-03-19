import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Constants/AppStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/Constants/AppStrings.dart';

class ApiManager {
  var headers;
  String aToken = '';

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  getCall(String url) async {
    var uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.get(uri);
    print("this is the resposne ${response.body}");
    // updateCookie(response);
    print(response.headers);
    // if (response.statusCode == 401) {
    //
    // } else {
    //
    //
    // }
    return await jsonDecode(response.body);
  }

  getCallwithheader(String url) async {
    // var headers;

    String user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppStrings.TOKEN_KEY) == null) {
      headers = {"Accept": "application/json"};
    } else {
      user = prefs.getString(AppStrings.TOKEN_KEY);
      print("user  ${user.split("|")[1]}");
      // headers = {HttpHeaders.contentTypeHeader: "Application/json", "authorization": "Bearer $user"};
    }
    var uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.get(uri, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer ${user.split("|")[1]}"
    });
    // final response = await http.get(url);
    print(response);

    print(url);
    print(response.body);

    return await jsonDecode(response.body);
    // return await response.data;
  }

  postCall(String url, Map request, BuildContext context) async {
    print("request " + request.toString());
    Map<String, String> header;
    header = {
      "Accept": "application/json",
    };
    // }
    var uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.post(
      uri,
      body: request,
      headers: header,
    );
    print(response.body);
    print("this is the header : ${response.headers}");
    if (response.statusCode == 401) {
    } else {
      return await json.decode(response.body);
    }
  }

  postCallWithHeader(String url, Map request, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(url);

    var headers;
    if (prefs.getString(AppStrings.TOKEN_KEY) == null) {
      headers = {"Accept": "application/json"};
    } else {
      String user = prefs.getString(AppStrings.TOKEN_KEY);
      print(user.split("|")[1]);
      //
      print("request " + request.toString());
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${user.split("|")[1]}",
      };
    }
    Uri uri = Uri.parse(url);
    // uri = uri.replace(queryParameters: request);
    print(uri);

    http.Response response =
        await http.post(uri, body: request, headers: headers);
    print(response.body);
    if (response.statusCode == 401) {
    } else {
      return await json.decode(response.body);
    }
  }

  // void updateCookie(http.Response response) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String rawCookie = response.headers['set-cookie'];
  //   prefs.setString(AppStrings.COOCKIE, rawCookie);
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf(';');
  //     headers['cookie'] =
  //         (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }
}
