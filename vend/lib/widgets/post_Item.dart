import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/postItem.dart';
import '../providers/postsProvider.dart';
import '../screens/postComments.dart';

class postItemS extends StatefulWidget with ChangeNotifier {
  final postItem p_item;
  List<postItem> posts = [];
  postItemS({required this.posts, required this.p_item});

  @override
  State<postItemS> createState() => _postItemSState();
}

class _postItemSState extends State<postItemS> {
  @override
  // void didChangeDependencies() {
  //   final postId = ModalRoute.of(context)!.settings.arguments as String?;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<Posts>(context);

    return GestureDetector(
      onTap: () {
        //fetchspecpost
        Navigator.of(context)
            .pushNamed(P_ComScreen.routeName, arguments: widget.p_item.post_id);
      },
      child: SizedBox(
        height: 200,
        width: 200,
        child: Container(
          // color: Colors.black26,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '  ${widget.p_item.user_id}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Spacer(),
                    Text('${widget.p_item.datetime.toString()}'),
                  ],
                ),
              ),
              Container(
                //   color: Colors.black26,
                child: Card(
                  margin: EdgeInsets.all(10),
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
                            '${widget.p_item.title}',
                            style: TextStyle(
                              // backgroundColor: Colors.black26,
                              fontFamily: 'Lato-bold',
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '${widget.p_item.content}',
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
                      //        IconButton(onPressed: null, icon: Icon(Icons.favorite)),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Data.fetchPost(widget.p_item);
                          },
                          icon: Icon(Icons.add_comment))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
