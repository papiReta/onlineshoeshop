import 'package:flutter/material.dart';
import 'package:shoe_node_api/data_provider/user_data_Provider.dart';
import 'package:shoe_node_api/model/response.dart';
import 'package:shoe_node_api/model/user.dart';

class UserRepo {
  final UserDataProvider userDataProvider;

  UserRepo({@required this.userDataProvider})
      : assert(userDataProvider != null);
  Future<ApiResponse> createUser(String username, String email,
      String phonenumber, String password) async {
    print("Repo user creating");
    return  userDataProvider.signup(
        username, email, phonenumber, password);
    print("Repo user created");
  }

  Future<ApiResponse> loginUser(
    String email,
    String password,
  ) async {
    print("Repo user Loginin");
    return  userDataProvider.signin(email, password);

    print("Repo user oaggedIn");
  }

  Future<User> getUserInfo(String email, String token) async {
    print("Getting User Profile .......");
    return await userDataProvider.getUserProfile(email, token);
  }

  Future<ApiResponse> logOut() async {
    print("Repo user Loginin");
    return await userDataProvider.signout();

    print("Repo user oaggedIn");
  }
}
