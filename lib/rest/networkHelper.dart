import 'dart:io';
import 'dart:io' show Platform;

//import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'urlConstants.dart';
import 'utility.dart';

class NetworkHelper {
  //static Alice alice;
  static Dio dio;
  NetworkHelper() {
    initAliceAndDio();
  }

  // ignore: missing_return
  Future<prefix0.Response<T>> post<T>(String url,
      {Map<String, dynamic> headers, body}) async {
    try {
      var header = headers == null ? Map<String, dynamic>() : headers;
      header = await _defaultPostHeader(header);
      var dataRes = await dio.post<T>(
        UrlConstants.host + url,
        data: body, //create a Stream<List<int>>
        options: Options(
          sendTimeout: 10000,
          receiveTimeout: 10000,
          headers: header,
        ),
      );
      return dataRes;
    } catch (eexception) {
      if (eexception is DioError) {
        if (eexception.response != null) {
          T data = eexception.response.data;
          return new Response<T>(
            data: data,
            headers: eexception.response.headers,
            request: eexception.response.request,
            statusCode: eexception.response.statusCode,
            redirects: eexception.response.redirects,
            statusMessage: eexception.response.statusMessage,
          );
        }
      }
    }
  }

  // ignore: missing_return
  Future<prefix0.Response<T>> put<T>(String url,
      {Map<String, dynamic> headers, body}) async {
    try {
      var header = headers == null ? Map<String, dynamic>() : headers;
      header = await _defaultPostHeader(header);
      var dataRes = await dio.put<T>(
        UrlConstants.host + url,
        data: body, //create a Stream<List<int>>
        options: Options(
          sendTimeout: 10000,
          receiveTimeout: 10000,
          headers: header,
        ),
      );
      return dataRes;
    } catch (eexception) {
      if (eexception is DioError) {
        if (eexception.response != null) {
          T data = eexception.response.data;
          return new Response<T>(
            data: data,
            headers: eexception.response.headers,
            request: eexception.response.request,
            statusCode: eexception.response.statusCode,
            redirects: eexception.response.redirects,
            statusMessage: eexception.response.statusMessage,
          );
        }
      }
    }
  }

  Future<Response> get<T>(url,
      {Map<String, dynamic> queryParams, Map<String, dynamic> headers}) async {
    var header = headers == null ? Map<String, dynamic>() : headers;
    var response;
    try {
      response = await dio.get<T>(
        url,
        queryParameters: queryParams,
        options: Options(
          sendTimeout: 10000,
          receiveTimeout: 10000,
          headers: await _defaultGetHeaders(header),
        ),
      );
    } catch (eexception) {
      if (eexception is DioError) {
        if (eexception.response != null) {
          T data = eexception.response.data;
          return new Response<T>(
            data: data,
            headers: eexception.response.headers,
            request: eexception.response.request,
            statusCode: eexception.response.statusCode,
            redirects: eexception.response.redirects,
            statusMessage: eexception.response.statusMessage,
          );
        }
      }
    }
    return response;
  }

  Future<Map<String, dynamic>> _defaultGetHeaders(
      Map<String, dynamic> headers) async {
    var defaultGetVAlue = {
      "content-type": "application/json",
      "x-app-version": await Utility.getAppVersion(),
      "x-os": Platform.operatingSystem,
      "x-app-type": "random",
    };

    headers.addAll(defaultGetVAlue);
    return headers;
  }

  Future<Map<String, dynamic>> _defaultPostHeader(
      Map<String, dynamic> headers) async {
    var defaultPostVAlue = {
      "content-type": "application/json",
      HttpHeaders.cacheControlHeader: "no-cache",
      "x-app-version": await Utility.getAppVersion(),
      "x-os": Platform.operatingSystem,
      "x-app-type": "random",
    };

    headers.addAll(defaultPostVAlue);
    return headers;
  }

  bool shouldLogout(int statusCode) {
    return (statusCode == 401 || statusCode == 403);
  }

  static void initAliceAndDio() {
    if (dio == null) {
      //alice = Alice(showNotification: true,showInspectorOnShake: true,
      navigatorKey:
      GlobalKey<NavigatorState>(debugLabel: "Alice");
      dio = new Dio();
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError e) {
        print(e.toString());
        // Do something with response error
        return e; //continue
      }));
      /*    dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        compact: false,
      ));
       */
      //dio.interceptors.add(alice.getDioInterceptor());
    }
  }
}
