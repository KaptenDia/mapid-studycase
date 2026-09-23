class RegisterReq {
  String? name;
  String? email;
  String? phone;
  String? password;

  RegisterReq({this.name, this.email, this.phone, this.password});

  RegisterReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
