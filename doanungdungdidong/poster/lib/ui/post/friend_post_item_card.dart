import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poster/ui/auth/auth_manager.dart';
import '../../models/post.dart';
import '../../ui/post/post_manager.dart';
import 'package:provider/provider.dart';

class FriendPostItemCard extends StatefulWidget {
  final Post post;
  const FriendPostItemCard(this.post, {super.key});

  @override
  State<FriendPostItemCard> createState() => _FriendPostItemCardState();
}

class _FriendPostItemCardState extends State<FriendPostItemCard> {
  String getAvatar() {
    var a = widget.post.users;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    print('b la ${b['avatar']}');
    return b['avatar'];
  }

  int getLike() {
    print('-----------------------------------------------------------------');
    var a = widget.post.like;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    if (b['id_user'].isEmpty) {
      print('rong roi');
    } else {}

    return b['numLike'];
  }

  bool isLike(String? userid) {
    var i = 0;
    // print('-------------------------------------------------${post.like}----------------');
    var a = widget.post.like;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    print("id sanpham :${b}");

    if (b['id_user'].isEmpty) {
      print('da rong roi');
    } else {
      b['id_user'].forEach((element) => {
            if (element == userid) {i = 1}
          });

      if (i == 1) {
        return true;

        // isYourLike=true;
      }
    }
    print(i);

    return false;

    // print(isYourLike);
  }

  String getName() {
    print(
        '-------------------------eeeeeeeeeeee----------------------------------------');
    var a = widget.post.users;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    // print(b[0]['name']);
    return b['name'];
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),

      // color: Colors.red,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AuthorCard(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            widget.post.title,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Expanded(
            child: GridTile(
                footer: GridTileBar(
                    leading: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await context
                                .read<ProductsManager>()
                                .isLike(widget.post.id!);
                            context
                                .read<ProductsManager>()
                                .fetchProductsSingle();
                          },
                          icon: Icon(isLike(context
                                  .read<AuthManager>()
                                  .authToken
                                  ?.user_id)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Colors.red,
                        ),
                        Text(
                          '${getLike()}',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    backgroundColor: Colors.black87),
                child: Image.network(
                  'http://${dotenv.env['HOST']}:3000/image/${widget.post.img_post}',
                  fit: BoxFit.contain,
                )))
      ]),
    );
  }

  Widget AuthorCard() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => {print('hehe')}, // needed
                      child: CircleAvatar(
                        radius: 5,
                        backgroundImage: NetworkImage(
                            'http://${dotenv.env['HOST']}:3000/image/${getAvatar()}'),
                        backgroundColor: Colors.transparent,
                      )),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getName(),
                      style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                    ),
                    Text(
                      '${widget.post.dateTime}',
                      style: TextStyle(color: Colors.amber[100]),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
