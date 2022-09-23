import 'package:flutter/material.dart';
import 'package:vend/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../SignUp screen/signup_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.home,
              ),
            ),
          ],
        ));
  }
}
