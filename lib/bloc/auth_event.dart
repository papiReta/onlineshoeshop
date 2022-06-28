import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent() : super();
   @override
  List<Object> get props => [];
}

class AuthLogin extends AuthenticationEvent {
  final String email, password;

  AuthLogin(this.email, this.password);
  @override
  List<Object> get props => [email,password];
}
class AuthLogOut extends AuthenticationEvent{}