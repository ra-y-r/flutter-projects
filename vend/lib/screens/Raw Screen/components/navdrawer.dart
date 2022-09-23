import 'package:flutter/material.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Products/products.dart';

import '../../Categories/categories.dart';
import '../../Profile/Profile.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text(
              kUserName.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Products'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductScreen();
                  },
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CateScreen();
                  },
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text('Users'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
