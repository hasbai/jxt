abstract class ResponseItem {
  ResponseItem();
  ResponseItem.fromJson(Map<String, dynamic> json);
}

class BasicResponse<T> {
  int code;
  String message;
  T data;

  BasicResponse({required this.code, required this.message, required this.data});
  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse<T>(
      code: json['code'], message: json['message'], data: mappingT2Class(T, json['data']));
}

class ListResponse<T> {
  int code;
  String message;
  List<T> data;

  ListResponse({required this.code, required this.message, required this.data});
  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse<T>(
        code: json['code'],
        message: json['message'],
        data: List<T>.from([for (var x in json['items']) mappingT2Class(T, x)]),
      );
}

class Page<T> implements ResponseItem {
  int page;
  int pageSize;
  int total;
  List<T> items;
  Page({required this.page, required this.pageSize, required this.total, required this.items});

  factory Page.fromJson(Map<String, dynamic> json) => Page<T>(
        page: json['page'],
        pageSize: json['pageSize'],
        total: json['total'],
        items: List<T>.from([for (var x in json['items']) mappingT2Class(T, x)]),
      );
}

class LaundryRoom implements ResponseItem {
  int id;
  int shopId;
  String name;
  dynamic area;
  String address;
  double distance;
  int state;
  int appointmentState;
  bool rechargeFlag;
  int idleCount;
  String workTime;

  LaundryRoom({
    required this.id,
    required this.shopId,
    required this.name,
    required this.area,
    required this.address,
    required this.distance,
    required this.state,
    required this.appointmentState,
    required this.rechargeFlag,
    required this.idleCount,
    required this.workTime,
  });

  factory LaundryRoom.fromJson(Map<String, dynamic> json) => LaundryRoom(
        id: json["id"],
        shopId: json["shopId"],
        name: json["name"],
        area: json["area"],
        address: json["address"],
        distance: json["distance"]?.toDouble(),
        state: json["state"],
        appointmentState: json["appointmentState"],
        rechargeFlag: json["rechargeFlag"],
        idleCount: json["idleCount"],
        workTime: json["workTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shopId": shopId,
        "name": name,
        "area": area,
        "address": address,
        "distance": distance,
        "state": state,
        "appointmentState": appointmentState,
        "rechargeFlag": rechargeFlag,
        "idleCount": idleCount,
        "workTime": workTime,
      };
}

class WashingMachine implements ResponseItem {
  int id;
  String name;
  String floorCode;
  int state;
  bool available;
  int category = 0;

  WashingMachine({
    required this.id,
    required this.name,
    required this.floorCode,
    required this.state,
  }) : available = state == 1;

  factory WashingMachine.fromJson(Map<String, dynamic> json) => WashingMachine(
        id: json["id"],
        name: json["name"],
        floorCode: json["floorCode"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "floorCode": floorCode,
        "state": state,
      };
}

dynamic mappingT2Class(Type t, Map<String, dynamic> json) {
  switch (t) {
    case LaundryRoom:
      return LaundryRoom.fromJson(json);
    case const (Page<LaundryRoom>):
      return Page<LaundryRoom>.fromJson(json);
    case WashingMachine:
      return WashingMachine.fromJson(json);
    case const (Page<WashingMachine>):
      return Page<WashingMachine>.fromJson(json);
    default:
      throw UnimplementedError('Unknown type');
  }
}
