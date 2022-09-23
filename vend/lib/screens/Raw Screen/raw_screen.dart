import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/bottom_nav_bar.dart';
import 'components/navdrawer.dart';

class RawScreen extends StatefulWidget {
  final Widget Container;
  final String AppBarTitle;
  const RawScreen(
      {Key? key, required this.Container, required this.AppBarTitle})
      : super(key: key);

  @override
  State<RawScreen> createState() => _RawScreenState();
}

class _RawScreenState extends State<RawScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      bottomNavigationBar: const BottomNavBar(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.AppBarTitle,
        ),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryLightColor,
      body: widget.Container,
    );
  }
}
