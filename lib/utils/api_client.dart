import 'dart:convert';

import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:product_app/utils/app_const.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  final Map<String, String> _mainHeader = {"Content-Type": 'application/json'};
  ApiClient({required this.sharedPreferences}) {
    if (sharedPreferences.getBool(AppConstant.ISUSERLOGIN) ?? false) {
      addHeader();
    }
  }
  addHeader() {
    _mainHeader.addAll({
      "Authorization":
          "Bearer ${sharedPreferences.getString(AppConstant.USERTOKEN)}",
    });
  }

  Future<Response> postData(String url, {Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      Http.Response response =
          await Http.post(uri, body: jsonEncode(body), headers: _mainHeader)
              .timeout(const Duration(seconds: 30));
      if (kDebugMode) {
        print("url===>$uri");
        print("body===> ${jsonEncode(body)}");
        print("Header===>$_mainHeader");
        print("RESPONSE ===>${response.body}");
      }

      return handelResponse(response, url);
    } catch (e) {
      if (kDebugMode) {
        print("error===>$e");
      }
      return Response(statusCode: 0, statusText: e.toString());
    }
  }

  Future<Response> getData(String url) async {
    try {
      Uri uri = Uri.parse(url);

      Http.Response response = await Http.get(uri, headers: _mainHeader);

      if (kDebugMode) {
        print("url===> $uri");
        print("Header===> $_mainHeader");
        print("Response ===>${response.body}");
      }

      return handelResponse(response, url);
    } catch (e) {
      if (kDebugMode) {
        print("error===>$e");
      }
      return Response(statusCode: 0, statusText: e.toString());
    }
  }

  Future<Response> putData(
    String uri,
    dynamic body,
  ) async {
    try {
      Http.Response response = await Http.put(
        Uri.parse(uri),
        body: jsonEncode(body),
        headers: _mainHeader,
      ).timeout(const Duration(seconds: 35));
      if (kDebugMode) {
        print('API Call ====>  $uri\n');
        print('API Header ====>  $_mainHeader\n');
        print('API Body ====>  ${jsonEncode(body)}');
        print("response ===> ${response.body}");
      }

      return handelResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print("ERORO ===> $e");
      }
      return const Response(statusCode: 1, statusText: "noInternetMessage");
    }
  }

  Future<Response> deleteData(
    String uri,
  ) async {
    try {
      Http.Response response = await Http.delete(
        Uri.parse(uri),
        headers: _mainHeader,
      ).timeout(const Duration(seconds: 35));
      if (kDebugMode) {
        print('API Call ====> : $uri');
        print('Response ====>: ${response.body}');
      }
      return handelResponse(response, uri);
    } catch (e) {
      if (kDebugMode) {
        print("ERORO ===> $e");
      }
      return const Response(statusCode: 1, statusText: "noInternetMessage");
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, MultipartBody multipartBody,
      {Map<String, String>? headers}) async {
    try {
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(uri));
      _request.headers.addAll(headers ?? _mainHeader);
      print("file upload header" + _request.headers.toString());
      if (multipartBody.unit8ListFile != null) {
        Uint8List _list = multipartBody.unit8ListFile;
        _request.files.add(Http.MultipartFile(
          multipartBody.key,
          Stream.value(
            List<int>.from(multipartBody.unit8ListFile),
          ),
          _list.length,
          filename: '${DateTime.now().toString()}.png',
        ));
      }

      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handelResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: "noInternetMessage");
    }
  }

  Response handelResponse(Http.Response response, String uri) {
    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: body != null ? body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (_response.statusCode != 200 ||
        _response.body == null ||
        _response.body is! String) {
      if (response.body.toString().contains('error')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body != null) {
      _response = Response(statusCode: 0, statusText: "No Internet");
    }
    return _response;
  }
}

class MultipartBody {
  String key;
  Uint8List unit8ListFile;

  MultipartBody(this.key, this.unit8ListFile);
}
