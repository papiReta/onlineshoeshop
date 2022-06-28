import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUser extends RegisterEvent {
  final String username;
  final String email;
  final String phonenumber;
  final String password;

  RegisterUser(this.username, this.email, this.phonenumber, this.password);
  @override
  List<Object> get props => [username,email,phonenumber,password];
}

// class UserNameChanged extends RegisterEvent {
//   final String username;

//   UserNameChanged(this.username);

//   @override
//   List<Object> get props => [username];
// }
// class EmailChanged extends RegisterEvent {
//   final String email;

//   EmailChanged(this.email);

//   @override
//   List<Object> get props => [email];
// }
// class PhoneNumberChanged extends RegisterEvent {
//   final String phonenumber;

//   PhoneNumberChanged(this.phonenumber);

//   @override
//   List<Object> get props => [phonenumber];
// }
// class PasswordChanged extends RegisterEvent {
//   final String password;

//   PasswordChanged(this.password);

//   @override
//   List<Object> get props => [password];
// }
