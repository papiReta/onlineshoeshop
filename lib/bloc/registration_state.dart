import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  RegisterInitial();
}

// class RegisterStateChanged extends RegisterState {
//   final User user;
//    RegisterStateChanged():super();

//   @override
//   List<Object> get props => [user];

// }

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String email;

  RegisterSuccess(this.email);
  @override
  List<Object> get props => [];
}
class RegisterFailed extends RegisterState{

}