import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/auth/auth_manager.dart';
import '../../models/post.dart';
import '../../ui/post/post_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

class PostItemCard extends StatefulWidget {
  final Post post;
  const PostItemCard(this.post, {super.key});

  @override
  State<PostItemCard> createState() => _PostItemCardState();
}

class _PostItemCardState extends State<PostItemCard> {
  // final Post post;
  // const PostItemCard(this.post,{super.key});
  //  late bool isYourLike =false;

  String getName() {
    //  print('-----------------------------------------------------------------');
    var a = widget.post.users;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    print(b['name']);
    return b['name'];
  }

  String getAvatar() {
    var a = widget.post.users;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    print(b['avatar']);
    return b['avatar'];
  }

  int getLike() {
    print('-----------------------------------------------------------------');
    var a = widget.post.like;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    if (b['id_user'].isEmpty) {
      print('rong roi');
    } else {
      // b['id_user'].forEach((element) =>
      //             // print(element)
      //       );
    }

    return b['numLike'];
  }

  String getID() {
    return widget.post.id_user;
  }

  bool isLike(String? userid) {
    var i = 0;
    // print('-------------------------------------------------${post.like}----------------');
    var a = widget.post.like;
    final productsMap = json.encode(a);
    var b = json.decode(productsMap);
    // b['id_user'].forEach((element) =>
    print("id sanpham :${b}");
    // );

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

  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
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

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AuthorCard(),
        //  Container(
        //   padding: EdgeInsets.all(10),
        //   width: double.infinity,
        //   color:Colors.white
        //   ,
        //   child:  Text(post.title),
        //  )
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
                            await context
                                .read<ProductsManager>()
                                .fetchProducts();
                          },
                          icon: Icon((isLike(context
                                  .read<AuthManager>()
                                  .authToken
                                  ?.user_id))
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
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      print('ud la ${getID()}');
                      await context
                          .read<ProductsManager>()
                          .fetchProductsFriend(getID());

                      Navigator.of(context).pushReplacementNamed('/friend');
                    }, // needed
                    child: CircleAvatar(
                      radius: 5,
                      backgroundImage: NetworkImage(
                          'http://${dotenv.env['HOST']}:3000/image/${getAvatar()}'),
                      backgroundColor: Colors.transparent,
                    ))),
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
        ));
  }
}
