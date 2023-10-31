import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jxt_toolkits/laundry/model.dart';

import 'laundryRoom.dart';

const ua = 'Hailelife/1.0.3 (iPhone; iOS 16.0.2; Scale/3.00)';
const baseUrl = 'https://yshz-user.haier-ioc.com';

final dio = Dio(BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  headers: {
    HttpHeaders.userAgentHeader: ua,
    HttpHeaders.contentTypeHeader: 'application/json',
  },
));

Future<List<LaundryRoom>> getLaundryRoom(
    {String lng = '***REMOVED***',
    String lat = '***REMOVED***'}) async {
  var resp = await dio.post(
    '/position/nearPosition',
    data: {'lng': lng, 'lat': lat, 'pageSize': 100},
  );
  var response =
      ListResponse<LaundryRoom>.fromJson(resp.data, LaundryRoom.fromJson);
  return response.data.items;
}
