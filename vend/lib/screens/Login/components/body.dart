import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/models/http_exception.dart';
import 'package:vend/models/logged.dart';
import 'package:vend/providers/auth.dart';
import 'package:vend/screens/Login/components/background.dart';
import 'package:vend/screens/Login/components/rounded_password_field.dart';
import 'package:vend/screens/Login/components/roundedinputfield.dart';
import 'package:vend/screens/SignUp%20screen/signup_screen.dart';
import 'package:vend/screens/Welcome/components/roundedbutton.dart';
import 'package:vend/screens/home/home_screen.dart';
import 'package:vend/screens/home/products_overview_screen.dart';

import 'already_have_an_account_check.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _isLoading = false;
  final _createFocusNode = FocusNode();
  final _SeccreateFocusNode = FocusNode();
  var _authData = logged(
    email: '',
    password: '',
  );

  @override
  void dispose() {
    _createFocusNode.dispose();
    _SeccreateFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
    try {
      await Provider.of<Auth>(context, listen: false).login(_authData).then(
          (value) => Navigator.of(context)
              .pushNamed(productsOverviewScreen.routeName));
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
    //   _formKey1.currentState!.save();
    // _formKey2.currentState!.save();
  }

  @override
  Widget frm() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          RoundedInputField(
            icon: Icons.person,
            hinText: "Your E-mail",
            onChanged: (value) {
              _authData = logged(email: '$value', password: _authData.password);
            },
          ),
          RoundedPasswordField(
            hintText: "Password",
            onChanged: (value) {
              _authData = logged(email: _authData.email, password: '$value');
            },
          )
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              frm(),
              RoundedButton(
                  text: "LOGIN",
                  press: () {
                    _savedis();
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                login: true,
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
      ),
    );
  }
}
