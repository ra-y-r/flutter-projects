// ignore: file_names
import 'package:vend/models/storyItem.dart';
import 'package:vend/providers/stroyProv.dart';
import 'stroyScreen.dart';
import '../models/logged.dart';
import '../models/postItem.dart';
import '../providers/postsProvider.dart';
import '../screens/postsScreen.dart';
import '../screens/home/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../screens/SignUp screen/signup_screen.dart';
import '../widgets/app_drawer.dart';

class createstory extends StatefulWidget {
  static const routeName = '/createo';
  @override
  State<StatefulWidget> createState() {
    return _createstoryState();
  }
}

class _createstoryState extends State<createstory> {
  var _isLoading = false;
  final _createFocusNode = FocusNode();
  final _SeccreateFocusNode = FocusNode();
  final timestamp = DateTime.now();
  var _authData = stItem(
    desc: '',
    img: '',
    price: '',
    quantity: '',
    story_id: 0,
    user_id: 0,
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
      await Provider.of<story>(context, listen: false).addStory(_authData).then(
          (value) => Navigator.of(context).pushNamed(storyScreen.routeName));
      ;
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
    //final Dat = Provider.of<postItem>(context);
    Color c2 = const Color(0XFF7884cc);
    Color c3 = const Color(0XFF96a8ff);
    return SizedBox(
      height: 600,
      child: Scaffold(
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
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //       SizedBox(height: 2),

              //     SizedBox(height: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //     margin: EdgeInsets.all(3),
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       'title of the post',
                  //       style: TextStyle(
                  //           decoration: TextDecoration.none,
                  //           color: Colors.blueGrey),
                  //     )),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_createFocusNode);
                    },
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(
                      labelText: '  desc',
                      //  prefixIcon: Icon(Icons.email, color: Colors.white),
                      hintText: '',
                      //fillColor: Colors.blueGrey,
                      //filled: true,
                      semanticCounterText: 'desc of the post',
                    ),
                    maxLength: 25,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'desc is Required';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _authData = stItem(
                        desc: "$value",
                        img: _authData.img,
                        price: _authData.price,
                        quantity: _authData.quantity,
                        story_id: _authData.story_id,
                        user_id: _authData.user_id,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_SeccreateFocusNode);
                    },
                    focusNode: _createFocusNode,
                    decoration: InputDecoration(
                      labelText: '  img',
                      //    prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: '',
                      //  fillColor: Colors.blueGrey,
                      // filled: true,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      semanticCounterText: 'img',
                    ),
                    maxLines: 3,
                    maxLength: 150,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _authData = stItem(
                        desc: _authData.desc,
                        img: "$value",
                        price: _authData.price,
                        quantity: _authData.quantity,
                        story_id: _authData.story_id,
                        user_id: _authData.user_id,
                      );
                    },
                    validator: (value) {
                      if (value == "") {
                        return 'Please enter something to post';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    // onFieldSubmitted: (_) {
                    //   FocusScope.of(context).requestFocus(_SeccreateFocusNode);
                    // },
                    focusNode: _createFocusNode,
                    decoration: InputDecoration(
                      labelText: '  price',
                      //    prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: '',
                      //  fillColor: Colors.blueGrey,
                      // filled: true,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      semanticCounterText: 'price',
                    ),
                    maxLines: 3,
                    maxLength: 150,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _authData = stItem(
                        desc: _authData.desc,
                        img: _authData.img,
                        price: "$value",
                        quantity: _authData.quantity,
                        story_id: _authData.story_id,
                        user_id: _authData.user_id,
                      );
                    },
                    validator: (value) {
                      if (value == "") {
                        return 'Please enter something to post';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    // onFieldSubmitted: (_) {
                    //   FocusScope.of(context).requestFocus(_SeccreateFocusNode);
                    // },
                    focusNode: _createFocusNode,
                    decoration: InputDecoration(
                      labelText: '  q',
                      //    prefixIcon: Icon(Icons.lock, color: Colors.white),
                      hintText: '',
                      //  fillColor: Colors.blueGrey,
                      // filled: true,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      semanticCounterText: 'q',
                    ),
                    maxLines: 3,
                    maxLength: 150,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _authData = stItem(
                        desc: _authData.desc,
                        img: _authData.img,
                        price: _authData.price,
                        quantity: "$value",
                        story_id: _authData.story_id,
                        user_id: _authData.user_id,
                      );
                    },
                    validator: (value) {
                      if (value == "") {
                        return 'Please enter something to post';
                      }
                      return null;
                    },
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: _savedis,
                    icon: Icon(Icons.post_add, color: Colors.white),
                    label: Text(
                      'post',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        // body: SingleChildScrollView(
        //   physics: ScrollPhysics(),
        //   child: Stack(children: [
        //     Positioned(
        //       child: Container(
        //           height: MediaQuery.of(context).size.height * 0.9,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(
        //               color: whiteshade,
        //               borderRadius: const BorderRadius.only(
        //                   topLeft: Radius.circular(45),
        //                   topRight: Radius.circular(45))),
        //           // margin: EdgeInsets.all(44),
        //           child: SingleChildScrollView(
        //             physics: ScrollPhysics(),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Container(
        //                   alignment: Alignment.center,
        //                   child: Form(
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: <Widget>[
        //                         // SizedBox(
        //                         //   height: 50,
        //                         // ),
        //                         frm(),
        //                         //    CheckerBox(),
        //                         SizedBox(height: 10),
        //                         if (_isLoading)
        //                           CircularProgressIndicator()
        //                         else
        //                           (TextButton.icon(
        //                             style: ButtonStyle(
        //                               backgroundColor:
        //                                   MaterialStateProperty.all<Color>(
        //                                       Colors.blueGrey),
        //                             ),
        //                             onPressed: () {
        //                               _savedis();
        //                             },
        //                             icon: Icon(Icons.post_add,
        //                                 color: Colors.white),
        //                             label: Text(
        //                               'post',
        //                               style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontSize: 16,
        //                               ),
        //                             ),
        //                           ))
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )),
        //     ),
        //   ]),
        // ),
        drawer: AppDrawer(),
      ),
    );
  }
}
