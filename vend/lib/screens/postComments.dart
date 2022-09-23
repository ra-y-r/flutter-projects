// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/postC.dart';
import '../models/postComment.dart';
import '../models/postItem.dart';

import '../providers/postCommentProvider.dart';
import '../providers/postsProvider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/postcommItem.dart';

class P_ComScreen extends StatefulWidget {
  static const routeName = '/post_comments';

  @override
  State<P_ComScreen> createState() => _P_ComScreenState();
}

class _P_ComScreenState extends State<P_ComScreen> {
  // Future<void> _Refresh(BuildContext context) async {
  //   await Provider.of<Posts>(context, listen: false).fetchAllcomments();
  // }

  var _isLoading = false;
  final _createFocusNode = FocusNode();
  var comment = PostCom(post_id: 0, user_id: 0, value: '');

  @override
  void dispose() {
    _createFocusNode.dispose();

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
      await Provider.of<Pcomment>(context, listen: false).addComment(comment);
    } catch (error) {
      const errorMessage = 'Could not add comment. Please try again later.';
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
    final post_id = ModalRoute.of(context)!.settings.arguments; // is the id!
    final Data = Provider.of<Pcomment>(context);
    final loadedProduct = Provider.of<Posts>(
      context,
      listen: false,
    ).findById(post_id.toString());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0XFFF000000),
        title: Text(loadedProduct.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '  ${loadedProduct.user_id}',
                  style: TextStyle(fontSize: 14),
                ),
                Spacer(),
                Text('${loadedProduct.datetime.toString()}'),
              ],
            ),
          ),
          Container(
            width: 100, height: 200,
            //   color: Colors.black26,
            child: Card(
              margin: EdgeInsets.all(20),
              // shadowColor: Colors.black,
              //     color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${loadedProduct.title}',
                        style: TextStyle(
                          // backgroundColor: Colors.black26,
                          fontFamily: 'Lato-bold',
                          fontSize: 17,
                        ),
                      ),
                      Divider(),
                      Text(
                        '${loadedProduct.content}',
                        style: TextStyle(
                          // backgroundColor: Colors.black26,
                          fontFamily: 'Lato-bold',
                          fontSize: 27,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            color: Colors.black26,
            child: Expanded(
              child: Row(
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.favorite)),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add_comment))
                ],
              ),
            ),
          ),
          //show comments here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) =>
                    postCItem(w_item: Data.comments[i], wishes: Data.com),
                itemCount: Data.itemcount,
              ),
            ),
          ),
          Divider(),

          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(3),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'add a comment',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.blueGrey),
                              )),
                          TextFormField(
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_createFocusNode);
                            },
                            autovalidateMode: AutovalidateMode.always,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.white),
                              hintText: '......',
                              fillColor: Colors.blueGrey,
                              filled: true,
                              semanticCounterText: 'comment ',
                            ),
                            maxLength: 25,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'comment is Required';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              comment = PostCom(
                                  post_id: loadedProduct.post_id,
                                  user_id: loadedProduct.user_id,
                                  value: '$value');
                            },
                          ),
                          SizedBox(height: 6),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            (TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueGrey),
                              ),
                              onPressed: _savedis,
                              icon: Icon(Icons.login, color: Colors.white),
                              label: Text(
                                'post',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
    );
  }
}
