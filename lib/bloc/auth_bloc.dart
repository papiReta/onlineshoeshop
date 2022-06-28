import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/bloc/auth_event.dart';
import 'package:shoe_node_api/bloc/auth_state.dart';
import 'package:shoe_node_api/repository/user_reposiroty.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;
  AuthenticationBloc({@required this.userRepo})
      : assert(userRepo != null),
        super(AuthenticationState.loggedOut());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthLogin) {
      yield AuthenticationState.loggingIn();
      try {
        print("Loggin In");
        final user = await userRepo.loginUser(event.email, event.password);
        final userInfo = await userRepo.getUserInfo(event.email, user.token);
        yield AuthenticationState.loggedIn(userInfo);

        print("Logged in");
      } catch (e) {
        print(e);
        yield AuthenticationState.loginFailed();
      }
    } else if (event is AuthLogOut) {
      await userRepo.logOut();
      yield AuthenticationState.loggedOut();
    }
  }
}
