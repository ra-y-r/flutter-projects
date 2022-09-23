import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vend/models/storyItem.dart';
import 'package:vend/providers/stroyProv.dart';
import '../models/postItem.dart';
import '../providers/postsProvider.dart';
import '../screens/postComments.dart';

class storyItemS extends StatefulWidget with ChangeNotifier {
  final stItem s_item;
  List<stItem> stories = [];
  storyItemS({required this.stories, required this.s_item});

  @override
  State<storyItemS> createState() => _storyItemSState();
}

class _storyItemSState extends State<storyItemS> {
  @override
  // void didChangeDependencies() {
  //   final postId = ModalRoute.of(context)!.settings.arguments as String?;

  //   super.didChangeDependencies();
  // }
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<story>(context);

    return GestureDetector(
        onTap: () {
          //fetchspecpost
          // Navigator.of(context)
          //     .pushNamed(P_ComScreen.routeName, arguments: widget.s_item.post_id);
        },
        child: SizedBox(
            height: 200,
            width: 200,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                ListTile(
                  title: Text('${widget.s_item.desc}'),
                  subtitle: Text(widget.s_item.user_id.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  ),
                ),
                if (_expanded)
                  SizedBox(
                      height: 100,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                                    child: SizedBox(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 90,
                                        child: Image.network(
                                          '${widget.s_item.img}',
                                          fit: BoxFit.cover,
                                          //height: 10,
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'id:    ${widget.s_item.story_id}'),
                                          Text(
                                              'quantity: ${widget.s_item.quantity}'),
                                          Text(
                                              'price:      ${widget.s_item.price.toString()}'),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      )),
              ]),
            )));
  }
}
