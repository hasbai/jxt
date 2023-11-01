class ListResponse<T> {
  int code;
  String message;
  ListResponseData<T> data;
  ListResponse({required this.code, required this.message, required this.data});
  factory ListResponse.fromJson(
          json, T Function(Map<String, dynamic> o) fromJson) =>
      ListResponse<T>(
        code: json['code'],
        message: json['message'],
        data: ListResponseData.fromJson(json['data'], fromJson),
      );
}

class ListResponseData<T> {
  int page;
  int pageSize;
  int total;
  List<T> items;
  ListResponseData(
      {required this.page,
      required this.pageSize,
      required this.total,
      required this.items});

  factory ListResponseData.fromJson(Map<String, dynamic> json,
          T Function(Map<String, dynamic> o) fromJson) =>
      ListResponseData<T>(
        page: json['page'],
        pageSize: json['pageSize'],
        total: json['total'],
        items: List<T>.from([for (var x in json['items']) fromJson(x)]),
      );
}

class ResponseItem {
  ResponseItem();
  factory ResponseItem.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

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

class WashingMachine {
  int id;
  String name;
  String floorCode;
  int state;
  int category = 0;

  WashingMachine({
    required this.id,
    required this.name,
    required this.floorCode,
    required this.state,
  });

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
