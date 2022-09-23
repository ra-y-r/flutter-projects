import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/providers/auth.dart';
import 'package:vend/screens/Categories/categories.dart';
import 'package:vend/screens/SignUp%20screen/signup_screen.dart';
import 'package:vend/screens/stroyScreen.dart';
//import 'package:shopify/screens/postsScreen.dart';
import '../screens/Products/product_detail_screen.dart';
import '../screens/home/products_overview_screen.dart';
import '../screens/postsScreen.dart';

import '../screens/createPost.dart';

import '../screens/Products/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Auth>(
      context,
      listen: false,
    );
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.black12,
            title: Text('welcome'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(productsOverviewScreen.routeName);
            },
          ),

          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text('Orders'),
          //   onTap: () {
          //     // Navigator.of(context)
          //     //     .pushReplacementNamed(ordersScreen.routeName);
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('category'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CateScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text(' posts'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(postScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.post_add),
            title: Text(' story'),
            onTap: () {
              loadedProduct.logout();
              Navigator.of(context).pushReplacementNamed(storyScreen.routeName);
            },
          ),

          ListTile(
            leading: Icon(Icons.post_add),
            title: Text(' logOut'),
            onTap: () {
              loadedProduct.logout();
              Navigator.of(context)
                  .pushReplacementNamed(SignUpScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
