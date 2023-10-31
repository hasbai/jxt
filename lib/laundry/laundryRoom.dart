import 'dart:convert';

import 'model.dart';

List<LaundryRoom> laundryRoomFromJson(String str) => List<LaundryRoom>.from(json.decode(str).map((x) => LaundryRoom.fromJson(x)));

String laundryRoomToJson(List<LaundryRoom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaundryRoom extends ResponseItem {
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
