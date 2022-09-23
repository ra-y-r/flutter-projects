import 'package:flutter/material.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Raw%20Screen/raw_screen.dart';
import 'components/product_editing_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return RawScreen(
      AppBarTitle: "Products",
      Container: Scaffold(
        backgroundColor: kPrimaryLightColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ProductEditingScreen();
                },
              ),
            );
          },
          backgroundColor: kPrimaryLighterColor,
          child: const Icon(Icons.add),
        ),
        body: Container(),
      ),
    );
  }
}
