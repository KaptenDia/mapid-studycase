class LoginResp {
  String? token;
  User? user;

  LoginResp({this.token, this.user});

  LoginResp.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? username;
  String? firstname;
  String? lastname;

  User({this.username, this.firstname, this.lastname});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}
