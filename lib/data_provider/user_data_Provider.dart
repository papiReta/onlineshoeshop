import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:shoe_node_api/model/response.dart';
import 'package:shoe_node_api/model/user.dart';

class UserDataProvider {
  static const String ip = "192.168.42.165";
  static const String baseUrl = 'http://192.168.42.165:3000';
  static const String xAccesstoken = 'x-access-token';
  final Client httpClient;

  static UserDataProvider instance;

  UserDataProvider(this.httpClient);
  // factory UserDataProvider() => instance ??= UserDataProvider._internal();
  // UserDataProvider._internal(this.httpClient);

  Future<ApiResponse> signup(String username, String email, String phonenumber,
      String password) async {
    final url = new Uri.http('$ip:3000', '/signup');
    final body = <String, String>{
      'username': username,
      'email': email,
      'phonenumber': phonenumber,
      'password': password
    };
    final Response response = await httpClient.post(url, body: body);
    print("Response : ${response.statusCode}");
    if (response.statusCode == 200) {
      print("Response ${json.decode(response.body)}");
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To Create Use ..................");
    }
  }

  Future<User> getUserProfile(String email, String token) async {
    final url = Uri.http('$ip:3000', '/getuser/$email');
    final response = await httpClient.get(
      url,
      headers: {xAccesstoken: token},
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To get User");
    }
  }

  Future<ApiResponse> signin(String email, String password) async {
    final url = new Uri.http('$ip:3000', '/signin');
    final credentials = '$email:$password';
    final basic = 'Basic ${base64Encode(utf8.encode(credentials))}';
    final body = <String, String>{'email': email, 'password': password};
    final Response response = await httpClient.post(url,
        headers: {HttpHeaders.AUTHORIZATION: basic}, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Response ${json.decode(response.body)}");
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To login ...........");
    }
  }

  Future<ApiResponse> signout() async {
    final url = Uri.https(baseUrl, '/logout');
    final response = await httpClient.get(
      url,
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }
}
