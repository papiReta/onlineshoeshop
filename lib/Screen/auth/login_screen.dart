import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/Screen/User/customPage.dart';
import 'package:shoe_node_api/Screen/UserRouteArgument.dart';
import 'package:shoe_node_api/Screen/adminpage.dart';
import 'package:shoe_node_api/Screen/auth/register.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper1.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper2.dart';
import 'package:shoe_node_api/Screen/utils/waveClipper3.dart';
import 'package:shoe_node_api/Screen/widget/customBtn.dart';
import 'package:shoe_node_api/Screen/widget/customFormField.dart';
import 'package:shoe_node_api/bloc/auth_bloc.dart';
import 'package:shoe_node_api/bloc/auth_event.dart';
import 'package:shoe_node_api/bloc/auth_state.dart';
import 'package:shoe_node_api/bloc/registration_state.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode;

  final Map<String, dynamic> _user = {};

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
        backgroundColor: Colors.white,
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
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              

              // if(state.isFailed){

              // }
              return Form(
                key: _formKey,
                child: Column(
                  children: [
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

                            final AuthenticationEvent event = AuthLogin(
                                this._user['email'], this._user['password']);
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(event);
                          }

                          if (state.isAuthenticated) {
                print("Success Detected");
                final role = state.user.role.toString();
                print("This is State ROle : $role");
                if (state.user.role.toString() == 'Admin') {
                  Navigator.pushNamed(context, AdminPage.routeName);
                } else {
                  Navigator.pushNamed(context, CustomPage.routeName,arguments: UserRouteArgumnet(state.user));
                }
              } else if (state.isFailed) {
                print('Widget Failed To Login');
                // Scaffold.of(context).showSnackBar(
                //       SnackBar(
                //         content:Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //       Icon(Icons.warning),
                //       Text("Failed To Login")
                //     ],
                //   )

                // ));
              }
                        },
                        isLoading: state.isAuthenticating)
                  ],
                ),
              );
            }),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't Have An Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12)),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: Text("Sign Up",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          decoration: TextDecoration.underline)),
                )
              ],
            )
          ],
          // child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          //         builder: (context, state) {
          //       return Form(
          //           key: _formKey,
          //           child: Column(children: [
          //             TextFormField(
          //                 initialValue: '',
          //                 validator: (value) {
          //                   if (value.isEmpty) {
          //                     return 'Please enter product price';
          //                   }
          //                   return null;
          //                 },
          //                 decoration: InputDecoration(labelText: 'Product Price'),
          //                 onSaved: (value) {
          //                   this._user["email"] = value;
          //                 }),
          //             TextFormField(
          //                 initialValue: '',
          //                 validator: (value) {
          //                   if (value.isEmpty) {
          //                     return 'Please enter product image';
          //                   }
          //                   return null;
          //                 },
          //                 decoration: InputDecoration(labelText: 'Product Image'),
          //                 onSaved: (value) {
          //                   setState(() {
          //                     this._user["password"] = value;
          //                   });
          //                 }),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(vertical: 16.0),
          //               child: ElevatedButton.icon(
          //                 onPressed: () {
          //                   final form = _formKey.currentState;
          //                   if (form.validate()) {
          //                     form.save();
          //                     print(this._user['email']);

          //                     final AuthenticationEvent event = AuthLogin(
          //                         this._user['email'], this._user['password']);
          //                     BlocProvider.of<AuthenticationBloc>(context)
          //                         .add(event);

          //                     if (state.isAuthenticated) {
          //                       print("Success Detected");
          //                       final role = state.user.role.toString();
          //                       print("This is State ROle : $role");
          //                       if (state.user.role.toString() == 'Admin') {
          //                         Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) => AdminPage()));
          //                       } else {
          //                         Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) =>
          //                                     MainPage(state.user)));
          //                       }
          //                     }
          //                   }
          //                 },
          //                 label: state is RegisterLoading
          //                     ? Text("Loading")
          //                     : Text('SAVE'),
          //                 icon: state is RegisterLoading
          //                     ? Icon(Icons.circle)
          //                     : Icon(Icons.save),
          //               ),
          //             )
          //           ]));
          //     })),
        ));
  }
}
