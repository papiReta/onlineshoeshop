import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String role;
  final String phonenumber;
  final String password;

  User(
      {this.id,
      @required this.username,
      @required this.email,
      this.role,
      @required this.phonenumber,
      @required this.password});
  @override
  List<Object> get props => [id, username, email, role, phonenumber,password];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      phonenumber: json['phonenumber'],
      password: json['password'],

    );
  }
  @override
  String toString() =>
      'User {id:$id, name : $username,email:$email,role:$role,image:$phonenumber}';
}
