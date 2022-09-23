class resp {
  var data;
  String success;

  resp({
    required this.data,
    required this.success,
  });

  factory resp.fromJson(Map<String, dynamic> json) {
    return resp(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String token;
  String? name;

  Data({required this.token, this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json["token"] as String,
      //name: json["name"] as String,
    );
  }
}
