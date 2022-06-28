import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/Screen/User/pages/Home.dart';
import 'package:shoe_node_api/Screen/User/pages/setting.dart';
import 'package:shoe_node_api/Screen/UserRouteArgument.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/Screen/utils/oval_rightborder_clipper.dart';
import 'package:shoe_node_api/bloc/auth_bloc.dart';
import 'package:shoe_node_api/bloc/auth_state.dart';
import 'package:shoe_node_api/bloc/product_bloc.dart';
import 'package:shoe_node_api/data_provider/product_provider.dart';
import 'package:shoe_node_api/data_provider/user_data_Provider.dart';
import 'package:shoe_node_api/repository/product_repo.dart';
import 'package:shoe_node_api/repository/user_reposiroty.dart';

class CustomPage extends StatefulWidget {
  // final User user;
  static String routeName = '/customPage';
  UserRouteArgumnet args;
  // const CustomPage( this.user);
  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final ProductRepo productRepo = ProductRepo(
      productDataProvider: ProductDataProvider(httpClient: Client()));
  final UserRepo userRepo =
      UserRepo(userDataProvider: UserDataProvider(Client()));
  int _currentindex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];
  @override
  void initState() {
    _children.add(HomeScreen());
    // _children.add(Messages());
    // _children.add(Notifications());
    // _children.add(Center(child: Text("Home 4")));
    _children.add(Setting());

    _appBars.add(_buildAppBar("Home"));
    _appBars.add(_buildAppBar("Message"));
    _appBars.add(_buildAppBar("Notifications"));
    _appBars.add(_buildAppBar("Near Me"));
    _appBars.add(_buildAppBar("Settings"));
  }

  @override
  Widget build(BuildContext context) {
    widget.args = ModalRoute.of(context).settings.arguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(userRepo: userRepo)),
        BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(productRepo: productRepo)),
      ],
      child: Scaffold(
        key: _key,
        appBar: _appBars[_currentindex],
        body: _children[_currentindex],
        drawer: _buildDrawer(context, widget.args),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: _onTabTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.category), title: Text("Shop")),
        BottomNavigationBarItem(
            icon: Icon(Icons.search), title: Text("Search")),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), title: Text("Notifications")),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_on), title: Text("Near me")),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Settings")),
      ],
      currentIndex: 0,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      selectedFontSize: 18,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  Widget _buildDrawer(BuildContext context, UserRouteArgumnet args) {
    final String image = "assets/nikeshoes2.jpeg";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: Constant.primary,
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            icon: Icon(
                              Icons.power_settings_new,
                              color: Constant.active,
                            ),
                            onPressed: () {
                              // FirebaseAuth.instance.signOut();
                            }),
                      ),
                      Container(
                        height: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange])),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(image),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "args.user.username",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text("args.user.email",
                          style: TextStyle(
                              color: Constant.active, fontSize: 16.0)),
                      SizedBox(height: 30.0),
                      _buildDevider()
                    ]),
                  ),
                  _buildRow(Icons.home, "Home"),
                  SizedBox(height: 5.0),
                  _buildRow(Icons.person, "Account"),
                  SizedBox(height: 5.0),
                  _buildRow(Icons.supervised_user_circle, "About"),
                  SizedBox(height: 10.0),
                  _buildRow(Icons.settings, "Contact"),
                  SizedBox(height: 10.0),
                  _buildRow(Icons.help, "Help Us"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDevider() {
    return Divider(
      color: Constant.divider,
    );
  }

  _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: Constant.active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Constant.active,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
                color: Colors.deepOrange,
                elevation: 5.0,
                shadowColor: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text("10"),
                ))
        ],
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search Here...",
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                    border: InputBorder.none,
                    prefixIcon: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(Icons.search)),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.mic))),
              ),
            ),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(80.0),
    );
  }

  Widget _buildHomeAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      title: Text("Home Page"),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _key.currentState.openDrawer();
          print("Clicked Menu");
        },
      ),
      centerTitle: true,
      bottom: _buildBottomBar(),
    );
  }

  Widget _buildAppBar(String title) {
    return AppBar(
      backgroundColor: Colors.red,
      title: Text(title),
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _key.currentState.openDrawer();
        },
      ),
      centerTitle: true,
    actions: [
      IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
        Navigator.pushNamed(context, '/cart');})
            // IconButton(
            //     icon: Icon(Icons.shopping_cart),
            //     onPressed: ()=>Navigator.pushNamed(context, '/cart'),
            //   )
      ],
      
    );
  }
}
