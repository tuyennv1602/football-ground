import 'package:dio/dio.dart';

var dio = new Dio(
  BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: 'application/json; charset=utf-8',
      baseUrl: 'http://192.168.1.173:8088/'),
//      baseUrl: 'http://192.168.1.24:8088/'),
);
