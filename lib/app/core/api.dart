// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/app/common/constants.dart';

const DEFAULT_TIMEOUT_TIME = Duration(minutes: 1);
const REFRESHTOKEN_TIMEOUT_TIME = Duration(seconds: 15);
const int DEFAULT_QTD_TRIES = 1;
const STATUS_CODE_SUCCESS = [200, 201, 204];

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

class Api {
  // static String? token;
  // static String apiKey = '';

  static String apiKey = "?api_key=11aacff4da3faa6609f04dd348819550";

  static String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMWFhY2ZmNGRhM2ZhYTY2MDlmMDRkZDM0ODgxOTU1MCIsInN1YiI6IjYzM2Q3ZTk3YzJmZjNkMDA3ZDk1ODRlNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.o3d31PVDjOt04_hRVarUWKbX2mMdtj-NeBCMmhrHkIk";
  static String language = "&language=pt-BR";
  Api();

  Future<Response?> getApi(String apiName, String endpoint, {String parameters = '', bool useAuth = true}) async {
    if (useAuth) {
      if (token == null) throw Exception('Authentication not performed yet.');
      var json = await tryToMakeRequest(RequestMethod.GET, apiName + endpoint + apiKey + language + parameters);
      return json;
    } else {
      var json = await tryToMakeRequest(RequestMethod.GET, apiName + endpoint, headers: getDefaultHeaders(withToken: false));
      return json;
    }
  }

  Future<Response?> postApi(String apiName, String endpoint, Map<String, dynamic> data, {bool useAuth = true, Map<String, String>? headers}) async {
    if (useAuth) {
      if (token == null) throw Exception('Authentication not performed yet.');
      var json = await tryToMakeRequest(RequestMethod.POST, apiName + endpoint, body: data, headers: {...(headers ?? {}), ...getDefaultHeaders(withToken: true)});
      return json;
    } else {
      var json = await tryToMakeRequest(RequestMethod.POST, apiName + endpoint, body: data, headers: headers ?? getDefaultHeaders(withToken: false));
      return json;
    }
  }

  Future<Response?> putApi(String apiName, String endpoint, Map<String, dynamic> data) async {
    if (token == null) throw Exception('Authentication not performed yet.');
    var json = await tryToMakeRequest(RequestMethod.PUT, apiName + endpoint, body: data);
    return json;
  }

  Future<Response?> deleteApi(String apiName, String endpoint, Map<String, dynamic> data) async {
    if (token == null) throw Exception('Authentication not performed yet.');
    var json = await tryToMakeRequest(RequestMethod.DELETE, apiName + endpoint, body: data);
    return json;
  }

  Future<String?> getDeviceIp() async {
    var json = await tryToMakeRequest(RequestMethod.GET, 'https://api.ipify.org/?format=text', headers: {});
    if (json != null && json.statusCode == 200 && json.data is String) return json.data;
    return null;
  }

  static Future<Response?> tryToMakeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Response? resp;
    for (var i = 0; i < DEFAULT_QTD_TRIES; i++) {
      try {
        resp = await makeRequest(method, url, headers: headers, body: body).timeout(DEFAULT_TIMEOUT_TIME);
        log('$method - $url - ${resp.statusCode} - ${resp.statusMessage}');
        break;
      } on TimeoutException catch (_) {
        // A timeout occurred.
        resp = _onTimeout();
      } on SocketException catch (_) {
        // Other exception
        _onInternetFailed();
      }
      if (resp != null) break;
    }

    if (resp == null) return null;
    try {
      return resp;
    } catch (e) {
      return null;
    }
  }

  static Future<Response> makeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    headers ??= getDefaultHeaders();
    Dio client = Modular.get<Dio>();
    Response resp;
    try {
      switch (method) {
        case RequestMethod.GET:
          resp = await client.get(url, options: Options(headers: headers));
          break;
        case RequestMethod.POST:
          resp = await client.post(url, options: Options(headers: headers), data: body);
          break;
        case RequestMethod.DELETE:
          resp = await client.delete(url, options: Options(headers: headers));
          break;
        case RequestMethod.PUT:
          resp = await client.put(url, options: Options(headers: headers), data: body);
          break;
        default:
          throw const SocketException('METHOD NOT SUPPORTED');
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        resp = Response(
          statusMessage: apiMessages[408],
          statusCode: 408,
          data: {},
          headers: e.response?.headers,
          requestOptions: RequestOptions(path: ''),
        );
        sendLogError(resp);
        return resp;
      }
      String message = '';
      dynamic data = {};
      if (e.response != null) {
        data = e.response!.data is String
            ? e.response!.data.isNotEmpty
                ? {"message": e.response!.data}
                : {}
            : e.response!.data ?? {};
        switch (e.response?.statusCode) {
          case 400:
          case 401:
          case 404:
          case 408:
          case 409:
          case 500:
          case 503:
          case 504:
            message = apiMessages[e.response?.statusCode]!;
            break;
          default:
            message = e.response?.statusMessage ?? apiMessages[0]!;
            break;
        }
      } else {
        message = apiMessages[0]!;
      }
      resp = Response(
        statusMessage: message,
        statusCode: e.response?.statusCode,
        data: data,
        headers: e.response?.headers,
        requestOptions: RequestOptions(path: ''),
      );
      sendLogError(resp);
    }
    return resp;
  }

  static sendLogError(Response resp) {
    Map<String, dynamic> error = {
      'url': resp.realUri.toString(),
      'headers': resp.headers.map.toString(),
      'data': resp.data.toString(),
      'statusCode': resp.statusCode.toString(),
      'statusMessage': resp.statusMessage,
    };
    log("log: ${error.toString()}");
  }

  static Map<String, String> getDefaultHeaders({bool withToken = true}) {
    if (withToken) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json; charset=utf-8",
        'accept': 'application/json, text/plain, */*',
      };
    } else {
      return {
        'Content-Type': "application/json; charset=utf-8",
        'accept': 'application/json, text/plain, */*',
      };
    }
  }

  static _onTimeout() {
    log('TIMEOUT!');
    return Response(
      statusMessage: apiMessages[408],
      statusCode: 408,
      requestOptions: RequestOptions(path: ''),
    );
  }

  static _onInternetFailed() {
    log("CONNECTION FAILED!");
  }
}
