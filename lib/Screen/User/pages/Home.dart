import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/Screen/User/pages/productDetail.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/bloc/product_bloc.dart';
import 'package:shoe_node_api/bloc/product_event.dart';
import 'package:shoe_node_api/bloc/product_state.dart';
import 'package:shoe_node_api/data_provider/product_provider.dart';
import 'package:shoe_node_api/repository/product_repo.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepo productRepo = ProductRepo(
      productDataProvider: ProductDataProvider(httpClient: Client()));
 
  @override
  Widget build(BuildContext context) {
    return
    MultiBlocProvider(
      providers: [
       BlocProvider(
              create: (context) =>
            ProductBloc(productRepo: this.productRepo)..add(ProductLoad())),
      ], 

      // child: Scaffold(
      //     appBar: AppBar(
      //       title: Text("Products"),
      //       actions: <Widget>[
      //     
      //       ],
      //     ),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingFailed) {
              return Center(
                  child: Text("Product Loading Failed",
                      style: Constant.boldHeading));
            }
            
            if (state is ProductLoaded) {
            final products = state.product;
              // print("Products : $products");
              if (products.length == 0) {
                return Center(
                  
                  child: Column(
                    children: [
                         Text("No Product Available For Now",
                        style: Constant.boldHeading),
                      IconButton(
                        icon: Icon(Icons.leaderboard),
                        onPressed: (){
                                   context.read<ProductBloc>()
                                        .add(ProductLoad());
                        },
                      )
                    ],
                   
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh:()async{
                    return await context.read<ProductBloc>().add(ProductLoad());
                } ,
                child: ListView.builder(
                    
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                        return Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                            child: MaterialButton(
                              padding:EdgeInsets.all(0),elevation: 0.5,
                              color: Colors.white,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              onPressed: (){
                                 Navigator.of(context).pushNamed(productDetail.routeName,
                                arguments: products[index]);
                              },
                              child: Row(
                                children: <Widget>[
                                  
                                  Ink(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      'assets/nikeshoes2.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child:Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(products[index].name??"Product Name"),
                                                SizedBox(height: 5),
                                                Text("${products[index].price} Birr")
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon:Icon(Icons.shopping_cart),
                                            onPressed: (){},
                                          )
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),

                          );                    
                    }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
          // floatingActionButton: FloatingActionButton(
            // onPressed: () => Navigator.of(context).pushNamed(
            //   // AddProduct.routeName,
            //   // arguments: ProductArgument(update: false),
            // ),
            // child: Icon(Icons.add),
          );
          // ),
    // );
  }
}


