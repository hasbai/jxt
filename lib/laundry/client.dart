import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jxt_toolkits/laundry/model.dart';

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

Future<List<LaundryRoom>> getLaundryRooms(
    {String lng = '***REMOVED***', String lat = '***REMOVED***'}) async {
  var resp = await dio.post(
    '/position/nearPosition',
    data: {'lng': lng, 'lat': lat, 'pageSize': 100},
  );
  var response = ListResponse<LaundryRoom>.fromJson(resp.data, LaundryRoom.fromJson);
  return response.data.items;
}

const categoryWashingMachine = 0;
const categoryDryingMachine = 2;

Future<List<WashingMachine>> _getWashingMachines(int laundryID, int category) async {
  var resp = await dio.post(
    '/position/deviceDetailPage',
    data: {'positionId': laundryID.toString(), 'categoryCode': category.toString().padLeft(2, '0')},
  );
  var response = ListResponse<WashingMachine>.fromJson(resp.data, WashingMachine.fromJson);
  for (var i = 0; i < response.data.items.length; i++) {
    response.data.items[i].category = category;
  }
  return response.data.items;
}

Future<List<WashingMachine>> getWashingMachines(int laundryID) async {
  var results = await Future.wait([
    _getWashingMachines(laundryID, categoryWashingMachine),
    _getWashingMachines(laundryID, categoryDryingMachine),
  ]);
  return [...results[0], ...results[1]];
}
