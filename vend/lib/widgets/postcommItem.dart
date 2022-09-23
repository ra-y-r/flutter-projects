import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/postComment.dart';
import '../models/postItem.dart';

import 'package:intl/intl.dart';
import 'dart:math';

class postCommItem extends StatefulWidget {
  final PostCom w_item;
  List<PostCom> comms = [];
  postCommItem({required this.comms, required this.w_item});

  @override
  State<postCommItem> createState() => _postCommItemState();
}

class _postCommItemState extends State<postCommItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.w_item.user_id}'),
          ),
          if (_expanded)
            SizedBox(
              height: 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                // height: min(widget.wishes.length * 20 + 10, 100),
                child: ListView(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('    ${widget.w_item.value}'),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
