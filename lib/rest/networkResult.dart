import 'dart:convert';

import 'package:dio/dio.dart' as prefix0;
import 'package:http/http.dart';
import 'error_Model.dart';

class NetworkResult<T> {
  int code;
  STATUS status;
  ErrorModel error;
  T data;

  NetworkResult(this.code, this.status, this.error, this.data);

  NetworkResult.success(String data, T f(String json), this.code,
      {this.status = STATUS.SUCCESS}) {
    this.data = f(data);
  }

  NetworkResult.error(String json, {this.code = 0, this.status = STATUS.ERROR});

  @override
  String toString() {
    return 'NetworkResult{code: $code, status: $status, error: $error, data: $data}';
  }

  NetworkResult.unsuccessful(String json,
      {this.code, this.status = STATUS.UNSUCCESSFUL});

  NetworkResult.handle(Response response, T f(String jsonData)) {
    this.code = response.statusCode;
    try {
      if (code == 200) {
        this.status = STATUS.SUCCESS;
        this.data = f(response.body);
      } else {
        this.status = STATUS.UNSUCCESSFUL;
        this.error = ErrorModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      this.status = STATUS.ERROR;
      this.error = ErrorModel("No Internet Connection!");
    }
  }
  NetworkResult.handleRes(prefix0.Response response, T f(String jsonData)) {
    try {
      this.code = response.statusCode;
      if (code == 200) {
        this.status = STATUS.SUCCESS;
        this.data = f(response.data);
      } else {
        this.status = STATUS.UNSUCCESSFUL;
        this.error = ErrorModel.fromJson(json.decode(response.data));
      }
    } catch (e) {
      this.status = STATUS.ERROR;
      this.error = ErrorModel("No Internet Connection!");
    }
  }
}

enum STATUS { SUCCESS, UNSUCCESSFUL, ERROR }
