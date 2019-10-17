import 'package:footballground/models/ground.dart';

import 'role.dart';

class User {
  int id;
  String name;
  String userName;
  String avatar;
  String email;
  String phone;
  List<Role> roles;
  List<Ground> grounds;
  double wallet;

  User(
      {this.id,
      this.name,
      this.userName,
      this.avatar,
      this.email,
      this.phone,
      this.roles,
      this.grounds,
      this.wallet});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['username'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    if (json['role_list'] != null) {
      roles = new List<Role>();
      json['role_list'].forEach((v) {
        roles.add(new Role.fromJson(v));
      });
    }
    wallet = json['wallet'];
    if (json['ground_list'] != null) {
      grounds = new List<Ground>();
      json['ground_list'].forEach((v) {
        grounds.add(new Ground.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.userName;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.roles != null) {
      data['role_list'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.grounds != null) {
      data['ground_list'] = this.grounds.map((v) => v.toJson()).toList();
    }
    data['wallet'] = this.wallet;
    return data;
  }
}
