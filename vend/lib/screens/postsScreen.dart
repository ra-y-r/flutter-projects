import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/postItem.dart';
import '../providers/postsProvider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/post_Item.dart';
import 'createPost.dart';
import 'postComments.dart';

class postScreen extends StatefulWidget {
  static const routeName = '/posts';

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {
  Future<void> _Refresh(BuildContext context) async {
    await Provider.of<Posts>(context, listen: false).fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<Posts>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        title: Text(
          'Yummy corner',
          style: TextStyle(
            fontFamily: 'Caveat-Medium',
            color: Color(0XFFFFF9900),
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(createPost.routeName);
              },
              icon: Icon(Icons.post_add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _Refresh(context),
        child: ListView.builder(
          //      shrinkWrap: true,
          itemBuilder: (context, i) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                  color: Colors.black38, width: 2, style: BorderStyle.solid),
            ),
            child: postItemS(
              p_item: Data.item[i],
              posts: Data.items,
            ),
          ),
          itemCount: Data.itemcount,
          padding: EdgeInsets.all(10),

          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 1,
          //   childAspectRatio: 4 / 2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          // ),
        ),
      ),
      drawer: Drawer(child: AppDrawer()),
    );
  }
}
