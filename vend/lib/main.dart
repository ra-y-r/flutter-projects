import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Welcome/welcome_screen.dart';
import 'package:vend/screens/stroyScreen.dart';

import 'providers/auth.dart';
import 'providers/cate.dart';
import 'providers/postCommentProvider.dart';
import 'providers/postsProvider.dart';
import 'providers/products_provider.dart';
import 'providers/stroyProv.dart';
import 'screens/Categories/addcategory.dart';
import 'screens/Categories/categories.dart';
import 'screens/Login/login_screen.dart';
import 'screens/Products/product_detail_screen.dart';
import 'screens/Products/user_products_screen.dart';
import 'screens/SignUp screen/signup_screen.dart';
import 'screens/createPost.dart';
import 'screens/createStory.dart';
import 'screens/editting screen/edit_product_screen.dart';
import 'screens/home/products_overview_screen.dart';
import 'screens/postComments.dart';
import 'screens/postsScreen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: pref));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  MyApp({
    required this.sharedPreferences,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', []),
            update: (ctx, auth, previousProducts) => Products(auth.logtoken,
                previousProducts == null ? [] : previousProducts.items)),
        ChangeNotifierProxyProvider<Auth, Posts>(
          create: (ctx) => Posts('', []),
          update: (ctx, auth, previousOrders) => Posts(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),
        ChangeNotifierProxyProvider<Auth, Pcomment>(
          create: (ctx) => Pcomment('', []),
          update: (ctx, auth, previousOrders) => Pcomment(
              auth.logtoken, previousOrders == null ? [] : previousOrders.com),
        ),
        ChangeNotifierProxyProvider<Auth, categ>(
          create: (ctx) => categ('', []),
          update: (ctx, auth, previousOrders) => categ(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),
        ChangeNotifierProxyProvider<Auth, story>(
          create: (ctx) => story('', []),
          update: (ctx, auth, previousOrders) => story(auth.logtoken,
              previousOrders == null ? [] : previousOrders.items),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, ath, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Vendor',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: ath.isAuth ? productsOverviewScreen() : SignUpScreen(),
          routes: {
            // addPostComment.routeName: (context) => addPostComment(),
            P_ComScreen.routeName: (context) => P_ComScreen(),
            //  Details.routeName: (context) => Details(),
            //  WishlistScreen.routeName: (context) => WishlistScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            //  ordersScreen.routeName: (context) => ordersScreen(),
            // CartScreen.routeName: (context) => CartScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            productsOverviewScreen.routeName: (ctx) => productsOverviewScreen(),
            postScreen.routeName: (ctx) => postScreen(),
            createPost.routeName: (ctx) => createPost(),
            CateScreen.routeName: (ctx) => CateScreen(),
            storyScreen.routeName: (ctx) => storyScreen(),
            addcateg.routeName: (ctx) => addcateg(),
            createstory.routeName: (ctx) => createstory(),
          },
        ),
      ),
    );
  }
}
