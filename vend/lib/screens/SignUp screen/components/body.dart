import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/models/http_exception.dart';
import 'package:vend/models/user.dart';
import 'package:vend/providers/auth.dart';
import 'package:vend/screens/Login/components/rounded_password_field.dart';
import 'package:vend/screens/Login/components/roundedinputfield.dart';
import 'package:vend/screens/Login/login_screen.dart';

import 'package:vend/screens/SignUp screen/components/background.dart';
import 'package:vend/screens/Welcome/components/roundedbutton.dart';
import 'package:vend/screens/home/home_screen.dart';

import '../../Login/components/already_have_an_account_check.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var _userInfo = user(
    role: 'admin',
    name: '',
    email: '',
    password: '',
    passwordRepeat: '',
    facebook_url: '',
    phone_num: '',
    whatsapp_url: '',
  );
  var _isLoading = false;
  bool showWidget = false;

  final _createFocusNode = FocusNode();
  final _SeccreateFocusNode = FocusNode();

  @override
  void dispose() {
    _createFocusNode.dispose();
    _SeccreateFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget frm() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: size.height * 0.1,
        ),
        RoundedInputField(
          icon: Icons.person,
          hinText: "Your name",
          onChanged: (value) {
            _userInfo = user(
                role: _userInfo.role,
                name: '$value',
                email: _userInfo.email,
                password: _userInfo.password,
                passwordRepeat: _userInfo.passwordRepeat,
                facebook_url: _userInfo.facebook_url,
                phone_num: _userInfo.phone_num,
                whatsapp_url: _userInfo.whatsapp_url);
          },
        ),
        RoundedInputField(
          icon: Icons.person,
          hinText: "Your Email",
          onChanged: (value) {
            _userInfo = user(
                role: _userInfo.role,
                name: _userInfo.name,
                email: '$value',
                password: _userInfo.password,
                passwordRepeat: _userInfo.passwordRepeat,
                facebook_url: _userInfo.facebook_url,
                phone_num: _userInfo.phone_num,
                whatsapp_url: _userInfo.whatsapp_url);
          },
        ),
        RoundedInputField(
          icon: Icons.phone,
          hinText: "Your phone Number",
          onChanged: (value) {
            _userInfo = user(
                role: _userInfo.role,
                name: _userInfo.name,
                email: _userInfo.email,
                password: _userInfo.password,
                passwordRepeat: _userInfo.passwordRepeat,
                facebook_url: _userInfo.facebook_url,
                phone_num: '$value',
                whatsapp_url: _userInfo.whatsapp_url);
          },
        ),
        RoundedPasswordField(
          hintText: "Enter New Password",
          onChanged: (value) {
            _userInfo = user(
                role: _userInfo.role,
                name: _userInfo.name,
                email: _userInfo.email,
                password: '$value',
                passwordRepeat: _userInfo.passwordRepeat,
                facebook_url: _userInfo.facebook_url,
                phone_num: _userInfo.phone_num,
                whatsapp_url: _userInfo.whatsapp_url);
          },
        ),
        RoundedPasswordField(
          hintText: "Confirm Password",
          onChanged: (value) {
            _userInfo = user(
                role: _userInfo.role,
                name: _userInfo.name,
                email: _userInfo.email,
                password: _userInfo.password,
                passwordRepeat: "$value",
                facebook_url: _userInfo.facebook_url,
                phone_num: _userInfo.phone_num,
                whatsapp_url: _userInfo.whatsapp_url);
          },
        ),
        RoundedInputField(
            icon: Icons.person,
            hinText: "Your facebook account",
            onChanged: (value) {
              _userInfo = user(
                  role: _userInfo.role,
                  name: _userInfo.name,
                  email: _userInfo.email,
                  password: _userInfo.password,
                  passwordRepeat: _userInfo.passwordRepeat,
                  facebook_url: "$value",
                  phone_num: _userInfo.phone_num,
                  whatsapp_url: _userInfo.whatsapp_url);
            }),
        RoundedInputField(
            icon: Icons.person,
            hinText: "Your  whatsapp url",
            onChanged: (value) {
              _userInfo = user(
                  role: _userInfo.role,
                  name: _userInfo.name,
                  email: _userInfo.email,
                  password: _userInfo.password,
                  passwordRepeat: _userInfo.passwordRepeat,
                  facebook_url: _userInfo.facebook_url,
                  phone_num: _userInfo.phone_num,
                  whatsapp_url: "$value");
            }),
      ]),
    );
  }

  @override
  Future<void> _savedis() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      //_regData['name'] = _name;
      // _regData['email'] = _email;
      // _regData['password'] = _password;
      // _regData['c_password'] = _passwordRepeat;
      // _regData['facebook_url'] = _facebook_url;
      // _regData['phone_num'] = _phone_num;
      // _regData['whatsapp_url'] = _whatsapp_url;
      setState(() {
        _isLoading = true;
      });
    }

    try {
      await Provider.of<Auth>(context, listen: false).signup(_userInfo);
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
      print(error);
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    // await Provider.of<Auth>(context, listen: false).signup(_name, _email,
    //     _password, _passwordRepeat, _facebook_url, _phone_num, _whatsapp_url);
    setState(() {
      _isLoading = false;
    });

    //   _formKey1.currentState!.save();
    // _formKey2.currentState!.save();
//loading spinner
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            frm(),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                _savedis();
              },
              // () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return HomeScreen();
              //       },
              //     ),
              //   );
              // },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
              login: false,
            ),
          ],
        ),
      ),
    );
  }
}
