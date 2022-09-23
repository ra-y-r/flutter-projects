import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
//import '../widgets/app_drawer.dart';
//import '../providers/cart_provider..dart';
//import 'cart_screen.dart';
import 'package:http/http.dart' as http;
import 'package:vend/widgets/app_drawer.dart';
//import 'ordersScreen.dart';
//import '../widgets/21.1%20badge.dart.dart';
import '../../widgets/Products_Grid.dart';
import '../../widgets/product_item.dart';
import '../../providers/product.dart';
import '../../providers/products_provider.dart';

class productsOverviewScreen extends StatefulWidget {
  static const routeName = '/PRodSCreen';
  @override
  State<productsOverviewScreen> createState() => _productsOverviewScreenState();
}

class _productsOverviewScreenState extends State<productsOverviewScreen> {
  var _showOnlyFav = false;
  var currentIndex = 0;
  var _isInit = true;
  var _isloading = false;
  @override
  void initState() {
    //  Provider.of<Products>(context).fetchproducts();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isloading = true;
      });

      Provider.of<Products>(context).fetchproducts().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.black,
        title: Text(
          'Yummy corner',
          style: TextStyle(
            fontFamily: 'Caveat-Medium',
            color: Color(0XFFFFF9900),
          ),
          textAlign: TextAlign.start,
        ),
        /*Image.asset(
            //fixlater
            'assets/logo.png',
            alignment: Alignment.topLeft,
            height: 99.0,
            width: 99.0,
          ), */
        actions: <Widget>[
          TextButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'my account',
                style: TextStyle(fontSize: 10, color: Colors.white),
              )),
          // Consumer<Cart>(
          //   builder: (_, cartData, chi) {
          //     return Badge(
          //       child: IconButton(
          //         onPressed: () {
          //           Navigator.of(context).pushNamed(CartScreen.routeName);
          //         },
          //         icon: Icon(Icons.shopping_cart_outlined),
          //       ),
          //       value: cartData.itemcount.toString(),
          //       color: Color(0XFFF37475A),
          //     );
          //   },
          // ),
        ],
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  // AppBar(
                  //   toolbarHeight: 50,
                  //   backgroundColor: Color(0XFFF000000),
                  //   leading: TextButton(
                  //     //color: Color(0XFFFFFFFFF),
                  //     onPressed: () {
                  //       setState(() {
                  //         _showOnlyFav = false;
                  //       });
                  //     },
                  //     child: Text(
                  //       'Vegan',
                  //       style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //     ),
                  //     //icon: Icon(Icons.home),
                  //   ),
                  //   actions: [
                  //     // SizedBox(
                  //     //   width: 10,
                  //     // ),
                  //     // TextButton(
                  //     //   //color: Color(0XFFFFFFFFF),
                  //     //   onPressed: () {
                  //     //     setState(() {
                  //     //       _showOnlyFav = false;
                  //     //     });
                  //     //   },
                  //     //   child: Text(
                  //     //     'Vegan',
                  //     //     style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //     //   ),
                  //     //   //icon: Icon(Icons.home),
                  //     // ),
                  //     TextButton(
                  //       //color: Color(0XFFFFFFFFF),
                  //       onPressed: () {
                  //         setState(() {
                  //           _showOnlyFav = false;
                  //         });
                  //       },
                  //       child: Text(
                  //         'kids',
                  //         style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //       ),
                  //       //icon: Icon(Icons.home),
                  //     ),
                  //     TextButton(
                  //       //color: Color(0XFFFFFFFFF),
                  //       onPressed: () {
                  //         setState(() {
                  //           _showOnlyFav = false;
                  //         });
                  //       },
                  //       child: Text(
                  //         'diary',
                  //         style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //       ),
                  //       //icon: Icon(Icons.home),
                  //     ),
                  //     TextButton(
                  //       //color: Color(0XFFFFFFFFF),
                  //       onPressed: () {
                  //         setState(() {
                  //           _showOnlyFav = false;
                  //         });
                  //       },
                  //       child: Text(
                  //         'meats',
                  //         style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //       ),
                  //       //icon: Icon(Icons.home),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     TextButton(
                  //       //color: Color(0XFFFFFFFFF),
                  //       onPressed: () {
                  //         setState(() {
                  //           _showOnlyFav = false;
                  //         });
                  //       },
                  //       child: Text(
                  //         'eastern',
                  //         style: TextStyle(color: Color(0XFFFFFFFFF)),
                  //       ),
                  //       //icon: Icon(Icons.home),
                  //     ),
                  //     PopupMenuButton(itemBuilder: (context) => []),
                  //   ],
                  // ),
                  ProductsGridView(_showOnlyFav),
                ],
              ),
            ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 160,
      //       ),
      //       TextButton.icon(
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(ordersScreen.routeName);
      //         },
      //         icon: Icon(Icons.shopping_bag),
      //         label: Text(
      //           'Orders',
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      drawer: AppDrawer(),
      // bottomNavigationBar: CurvedNavigationBar(
      //     buttonBackgroundColor: Color(0XFFFFF9900),
      //     color: Color(0XFFF000000),
      //     height: 46,
      //     //animationCurve: Curves.bounceIn,
      //     animationDuration: Duration(milliseconds: 360),
      //     index: 1,
      //     backgroundColor: Color(0XFFF37475A),
      //     onTap: (value) => setState(
      //           () => currentIndex = value,
      //         ),
      //     items: [
      //       IconButton(
      //         alignment: Alignment.center,
      //         onPressed: () {
      //           setState(() {
      //             _showOnlyFav = true;
      //           });
      //         },
      //         icon: Icon(
      //           Icons.favorite,
      //           color: Color(0XFFF232F3E),
      //         ),
      //       ),
      //       IconButton(
      //           onPressed: () {
      //             setState(() {
      //               _showOnlyFav = false;
      //             });
      //           },
      //           icon: Icon(
      //             Icons.home_filled,
      //             color: Color(0XFFF232F3E),
      //           )),
      //       IconButton(
      //           onPressed: null,
      //           icon: Icon(
      //             Icons.search,
      //             color: Color(0XFFF232F3E),
      //             semanticLabel: 'search',
      //           )),
      //     ])
      //  BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     backgroundColor: Colors.blueAccent,
      //     selectedItemColor: Colors.white,
      //     unselectedItemColor: Colors.white60,
      //     currentIndex: currentIndex,
      //     onTap: (value) => setState(
      //           () => currentIndex = value,
      //         ),
      //     selectedFontSize: 18,
      //     showUnselectedLabels: false,
      //     unselectedFontSize: 13,
      //     items: const [
      //       BottomNavigationBarItem(
      //           tooltip: 'my account',
      //           activeIcon: IconButton(
      //               alignment: Alignment.bottomCenter,
      //               onPressed: null,
      //               icon: Icon(
      //                 Icons.person,
      //                 color: Colors.white,
      //               )),
      //           icon: Icon(Icons.person),
      //           label: ' account'),
      //       BottomNavigationBarItem(
      //           tooltip: 'home page',
      //           activeIcon: IconButton(
      //               onPressed: null,
      //               icon: Icon(
      //                 Icons.home_filled,
      //                 color: Colors.white,
      //               )),
      //           icon: Icon(Icons.home),
      //           label: 'home'),
      //       BottomNavigationBarItem(
      //           activeIcon: IconButton(
      //               onPressed: null,
      //               icon: Icon(
      //                 Icons.search,
      //                 color: Colors.white,
      //               )),
      //           tooltip: 'search item',
      //           icon: Icon(Icons.search),
      //           label: 'search'),
      //     ]),
    );
  }
}
