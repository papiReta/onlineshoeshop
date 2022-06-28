import 'package:flutter/material.dart';
import 'package:shoe_node_api/model/user.dart';

class AuthenticationState {
  final bool isAuthenticated;
  final bool isAuthenticating;
  final bool isFailed;
  final User user;

  AuthenticationState(
      {@required this.isAuthenticated,
      this.isAuthenticating = false,
      this.isFailed = false,
      this.user });

  factory AuthenticationState.loggedOut() {
    return AuthenticationState(isAuthenticated: false);
  }
  factory AuthenticationState.loggingIn() {
    return AuthenticationState(isAuthenticated: false, isAuthenticating: true);
  }
  factory AuthenticationState.loggedIn(User user) {
    return AuthenticationState(isAuthenticated: true,isAuthenticating: false,user: user);
  }

  factory AuthenticationState.loginFailed() {
    return AuthenticationState(isAuthenticated: false, isFailed: true);
  }
}
