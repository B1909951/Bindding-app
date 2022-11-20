import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/auth/auth_manager.dart';
import './friend_post_item_card.dart';
import './post_manager.dart';
import '../../models/post.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FriendPostsGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<ProductsManager>(
        builder: (context, productsManager, child) {
      var a = productsManager.posts[0];

      final productsMap = json.encode(a.u);
      var b = json.decode(productsMap);

      print('au ${b['avatar']}');
      var c = b['avatar'];
      var name = b['name'];
      return Column(
        children: [
          AuthorCard(c, name),
          Expanded(
              child: GridView.builder(
            //  controller: _scrollController,
            padding: const EdgeInsets.all(10),
            itemCount: productsManager.getCount,
            itemBuilder: ((context, index) =>
                FriendPostItemCard(productsManager.posts[index])),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
          ))
        ],
      );
    });
  }

  Widget AuthorCard(String? a, String? name) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  radius: 5,
                  backgroundImage: NetworkImage(
                      'http://${dotenv.env['HOST']}:3000/image/${a}'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${name}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
