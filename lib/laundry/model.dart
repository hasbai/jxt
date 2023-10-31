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
