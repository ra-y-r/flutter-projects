import 'package:flutter/material.dart';
import 'package:vend/screens/SignUp%20screen/signup_screen.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Login/login_screen.dart';
import 'package:vend/screens/Welcome/components/roundedbutton.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Vendor app",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }));
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
