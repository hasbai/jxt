import 'package:flutter/foundation.dart';

import 'client.dart';
import 'model.dart';

Future<List<LaundryRoom>> getLaundryRooms(
    {String lng = '***REMOVED***',
      String lat = '***REMOVED***'}) async {
  var resp = await dio.post(
    '/position/nearPosition',
    data: {'lng': lng, 'lat': lat, 'pageSize': 100},
  );
  var response = Page<LaundryRoom>.fromJson(resp.data);
  return response.items;
}

const categoryWashingMachine = 0;
const categoryDryingMachine = 2;

Future<List<WashingMachine>> _getWashingMachines(
    int laundryID, int category) async {
  var resp = await dio.post(
    '/position/deviceDetailPage',
    data: {
      'positionId': laundryID.toString(),
      'categoryCode': category.toString().padLeft(2, '0')
    },
  );
  var response = Page<WashingMachine>.fromJson(resp.data);
  for (var i = 0; i < response.items.length; i++) {
    response.items[i].category = category;
  }
  return response.items;
}

Future<List<WashingMachine>> getWashingMachines(int laundryID) async {
  var results = await Future.wait([
    _getWashingMachines(laundryID, categoryWashingMachine),
    _getWashingMachines(laundryID, categoryDryingMachine),
  ]);
  return [...results[0], ...results[1]];
}

Future<List<Sku>> getSkus(int machineID) async {
  var resp = await dio.get(
    '/goods/normal/items',
    queryParameters: {'goodsId': machineID.toString()},
  );
  var response = ListResponse<Sku>.fromJson(resp.data);
  return response.data;
}

Future<bool> createOrder(Sku sku,WashingMachine machine, String time) async {
  String path;
  if (kReleaseMode){
    path = "/trade/create";
  }else {
    path = "/trade/preview";
  }
  await dio.post(
    path,
    data: {
      "purchaseList": [{
        "goodsId": machine.id,
        "goodsItemId": sku.id,
        "soldType": machine.category == categoryWashingMachine ? 1 : 2,
        "num": machine.category == categoryWashingMachine ? "1" : time,
      }]
    },
  );
  return true;
}

Future<bool> sendVerifyCode(String phone) async {
  await dio.post(
    '/login/getCode',
    data: {'target': phone},
  );
  return true;
}

Future<String> login(String phone, String code) async {
  var resp = await dio.post(
    '/login/login',
    data: {
      'account': phone,
      'verificationCode': code,
      'loginType': "2",
    },
  );
  var token = resp.data['token'];
  if (token == null) {
    throw Exception('Login failed');
  }
  return token;
}
