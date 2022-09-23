import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/logged.dart';
import '../models/resp.dart';
import '../models/user.dart';
import '../screens/home/products_overview_screen.dart';

class Auth with ChangeNotifier {
  var _token;
  var _toke;
  var _logtoken;

  late List<resp> list;
  late List<resp> list2;
  // late DateTime _expiryDate;
  //late String _userId;

  bool get isAuth {
    return (token != '' && token != null);
  }

  String? get token {
    if (_token != '') {
      return _token;
    } else {
      return '';
    }
  }

  String? get logtoken {
    if (_toke != '') {
      return _toke;
    } else {
      return '';
    }
  }

//refreshtokens//

  Future<void> _authenticateSignup(user User) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {};
    user['role_name'] = User.role;
    user['name'] = User.name;
    user['email'] = User.email;
    user['password'] = User.password;
    user['c_password'] = User.passwordRepeat;
    user['facebook_url'] = User.facebook_url;
    user['phone_number'] = User.phone_num;
    user['whatsapp_url'] = User.whatsapp_url;

    var url = Uri.parse("http://10.0.2.2:8000/api/register");
    final response = await http.post(
      url,
      body: user,
      headers: {
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Connection': 'keep-alive',
      },
    );
    try {
      //var data=json.decode(json.encode(snapshot.data));
      var jsonobj = json.decode(response.body);
      // print(jsonobj);
      // if (jsonobj['success'] != true) {
      //   throw HttpException(jsonobj['error']['message']);
      // }
      // print(jsonobj['data']['token']);
      // _token = ['$token'];
      String _token = jsonobj['data']['token'];

      await prefs.setString('admintoken', _token);
      notifyListeners();

      // _userId = jsonobj['localId'];
      // _expiryDate = DateTime.now().add(
      //   Duration(
      //     minutes: 20,
      //   ),
      // );
      // if (isAuth) {
      //   Navigator.of(context).pushNamed(productsOverviewScreen.routeName);
      // }

      notifyListeners();
    } catch (e) {
      print(e);
    }

    // print(isAuth);
  }

  Future<void> authenticatelogin(logged log) async {
    Map<String, dynamic> user = {};
    user['email'] = log.email;
    user['password'] = log.password;
    SharedPreferences pref = await SharedPreferences.getInstance();

    var toke = pref.getString('admintoken');
    print(toke);
    Uri url = Uri.parse("http://10.0.2.2:8000/api/login");
    final response = await http.post(
      url,
      body: user,
      headers: {
        //HttpHeaders.authorizationHeader: 'Bearer $toke',

        /// 'Authorization': 'Bearer $suctoken',
        'Authorization': 'Bearer $toke',
        'Accept': 'application/json',
        'Charset': 'utf-8',
        'Connection': 'keep-alive',
      },
    );
    try {
      //var data=json.decode(json.encode(snapshot.data));
      var jsonoj = jsonDecode(response.body);

      // if (jsonoj['success'] != true) {
      //   throw HttpException(jsonoj['success']['message']);
      // }

      //  _toke = json.encode(jsonoj['token']);
      _toke = jsonoj['data']['token'];

      // await storage.write(key: 'logToken', value: _toke);

      //_toke = jsonoj[jsonoj.indexOf('token')];

      // const responseJson = jsonoj.response.json();
// var bodyToken = responseJson.access_token;

      //print(jsonoj);
      //   print(token);

      await pref.setString('adminlogToken', _toke);

      notifyListeners();
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<void> signup(user User) async {
    return _authenticateSignup(User);
  }

  Future<void> login(logged log) async {
    return authenticatelogin(log);
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('adminlogToken');
  }
}
