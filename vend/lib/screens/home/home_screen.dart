import 'package:flutter/material.dart';
import 'package:vend/screens/Raw%20Screen/raw_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScreen(
      AppBarTitle: "Home",
      Container: Scaffold(),
    );
  }
}
