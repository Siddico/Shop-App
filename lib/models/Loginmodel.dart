// ignore_for_file: unused_label

class ShopLoginModel {
  late bool status;
  late String message;
  late UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.phone,
      required this.points,
      required this.credit,
      required this.token});
//Named Constructor

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
