import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/Screen/auth/login_screen.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper1.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper2.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper3.dart';
import 'package:shoe_node_api/Screen/widget/customBtn.dart';
import 'package:shoe_node_api/Screen/widget/customFormField.dart';
import 'package:shoe_node_api/bloc/register_bloc.dart';
import 'package:shoe_node_api/bloc/register_event.dart';
import 'package:shoe_node_api/bloc/registration_state.dart';
import 'package:shoe_node_api/repository/user_reposiroty.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  final UserRepo userRepo;

  const RegisterScreen({Key key, this.userRepo}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState(this.userRepo);
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserRepo userRepo;
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _user = {};

  FocusNode passwordFocusNode;

  _RegisterScreenState(this.userRepo);

  @override
  void initState() {
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Color(0x22ff3a5a), Color(0x22fe494d)],
                    ))),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Color(0x44ff3a5a), Color(0x44fe494d)],
                    ))),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Icon(
                        Icons.shopping_basket,
                        color: Colors.white,
                        size: 60,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Commerce Login",
                        style: Constant.regularHeading,
                      )
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color(0xffff3a5a), Color(0xfffe494d)],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
            if (state is RegisterSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            } else if (state is RegisterFailed) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.warning), Text("Failed To Login")],
              )));
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  customFormField(
                    isObscured: false,
                    inputHintText: "Username",
                    icon: Icons.person,
                    validationText: "Please Enter UserName",
                    onSaved: (value) {
                      this._user['username'] = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customFormField(
                    isObscured: false,
                    inputHintText: "example@example.com",
                    icon: Icons.email,
                    validationText: "Please Enter Email Address",
                    onSaved: (value) {
                      this._user['email'] = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customFormField(
                    isObscured: false,
                    inputHintText: "phoneNumber",
                    icon: Icons.email,
                    validationText: "Please Enter PhoneNumber",
                    onSaved: (value) {
                      this._user['phonenumber'] = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customFormField(
                    focusNode: passwordFocusNode,
                    isObscured: true,
                    inputHintText: "Password",
                    icon: Icons.lock,
                    validationText: "Please Enter Password",
                    onSaved: (value) {
                      this._user['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  customBtn(
                      title: "Login",
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          print(this._user['email']);

                          final RegisterEvent event = RegisterUser(
                              this._user['username'],
                              this._user['email'],
                              this._user['phonenumber'],
                              this._user['password']);
                          BlocProvider.of<RegisterBloc>(context).add(event);
                        }
                      },
                      isLoading: state is RegisterLoading)
                ],
              ),
            );
          }),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already Have An Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12)),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context,
                      LoginScreen.routeName);
                },
                child: Text("Log In",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        decoration: TextDecoration.underline)),
              )
            ],
          )
        ],
      ),
    );
  }
}
