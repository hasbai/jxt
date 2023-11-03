import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';
import 'login.dart';

const ua = 'Hailelife/1.0.3 (iPhone; iOS 16.0.2; Scale/3.00)';
const baseUrl = 'https://yshz-user.haier-ioc.com';

void initDio(){
  dio.interceptors.add(LogInterceptor());
  dio.interceptors.add(MyInterceptor(
    navigatorKey: navigatorKeys[Pages.laundry]!,
    loginPage: Login(),
    tokenName: tokenNames[Pages.laundry]!,
  ));
}

final Dio dio = Dio(BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  headers: {
    HttpHeaders.userAgentHeader: ua,
    HttpHeaders.contentTypeHeader: 'application/json',
  },
));

class MyInterceptor extends Interceptor {
  MyInterceptor({
    required this.navigatorKey,
    required this.loginPage,
    required this.tokenName,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final StatelessWidget loginPage;
  final String tokenName;

  static const authenticatedEndpoints = <String>[
    '/trade/preview',
    '/trade/create',
  ];

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {

    if (!authenticatedEndpoints.contains(options.path)) {
      return handler.next(options);
    }
    // get token from storage
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(tokenName);
    if(kDebugMode){
      const env = String.fromEnvironment('TOKEN');
      if (env != '') {
        token = env;
      }
    }
    if (token == null) {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (_) => loginPage),
      );
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Unauthorized',
          response: Response(
            requestOptions: options,
            statusCode: 401,
            statusMessage: 'Unauthorized',
          ),
        ),
      );
    }
    options.headers.addAll({'Authorization': token});
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    int code = response.data['code'] == null
        ? response.statusCode
        : convertCustomCode(response.data['code']);

    if (code < 400 && response.data['data'] != null) { // success
      response.data = response.data['data'];
      return handler.next(response);
    }

    var msg = response.data['message'];
    switch (code) {
      case 401:
        msg = msg ?? 'Unauthorized';
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (_) => loginPage),
        );
        break;
      case 403:
        msg = msg ?? 'Forbidden';
        break;
      case 404:
        msg = msg ?? 'Not found';
        break;
      case 500:
        msg = msg ?? 'Internal server error';
        break;
      default:
        msg = msg ?? 'Unknown error';
        break;
    }
    var snackBar = SnackBar(
      content: Text(msg),
    );
    snackbarKey.currentState?.showSnackBar(snackBar);
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    var snackBar = SnackBar(content: Text(err.toString()));
    snackbarKey.currentState?.showSnackBar(snackBar);
    return handler.next(err);
  }
}

convertCustomCode(int code){
  switch (code) {
    case 0:
      return 200;
    case 2:
      return 401;
    default:
      return code;
  }
}