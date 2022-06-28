import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/Screen/route.dart';
import 'package:shoe_node_api/bloc/auth_bloc.dart';
import 'package:shoe_node_api/bloc/register_bloc.dart';
import 'package:shoe_node_api/bloc_observer.dart';
import 'package:shoe_node_api/data_provider/user_data_Provider.dart';
import 'package:shoe_node_api/repository/user_reposiroty.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepo userRepo =
      UserRepo(userDataProvider: UserDataProvider(Client()));
  runApp(MyApp(userRepo: userRepo));
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo;

  const MyApp({this.userRepo}) : assert(userRepo!=null);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value:this.userRepo, 
      child: MultiBlocProvider(
        providers: [
        BlocProvider<AuthenticationBloc>(create: (context)=>AuthenticationBloc(userRepo: userRepo)),
        BlocProvider<RegisterBloc>(create: (context)=>RegisterBloc(userRepo:userRepo))
        ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: MyRoute.generateRoute,
          )
        ),
      );
  }
}
