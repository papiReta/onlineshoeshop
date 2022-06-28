import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/bloc/register_event.dart';
import 'package:shoe_node_api/bloc/registration_state.dart';
import 'package:shoe_node_api/repository/user_reposiroty.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepo _userRepo;
  RegisterBloc({UserRepo userRepo})
      : _userRepo = userRepo,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUser) {
      yield* mapStateToRegisterUser(event);
    }
  }

  Stream<RegisterState> mapStateToRegisterUser(RegisterUser event) async* {
    RegisterLoading();
    try {
      print("Creating User ................");
      final user = await _userRepo.createUser(
          event.username, event.email, event.phonenumber, event.password);
      print("Created");
      yield RegisterSuccess(user.token);
      print("TOken "+user.token);
    } catch (e) {
      RegisterFailed();
      print("Reg Error :${e.toString()}");
    }
  }

  Future<bool> isValid(String userName, String email, String phonenumber,
      String password) async {
    // bool isValidUser = await _userRepo.isUserAvailable(userName); //username is available to create

    RegExp exp = new RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

    bool isUserNameValid = userName.length >= 8;
    bool isEmailValid = email.contains('@');
    bool isPhoneValid = phonenumber.length >= 10;
    bool isValidPassword = exp.hasMatch(
        password); // password should have one small case, one upper case, one number and one symbol
    // bool isConfirmPasswordMatched = password == confirmPassword; // confirm password should match with the above password

    // return isValidUser &&
    return isUserNameValid && isEmailValid && isPhoneValid && isValidPassword;
  }
}
