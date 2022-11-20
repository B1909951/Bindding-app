import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './post_item_card.dart';
import './post_manager.dart';
import '../../models/post.dart';
import 'package:provider/provider.dart';

class PostsGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<ProductsManager>(
        builder: (context, productsManager, child) {
      return GridView.builder(
          //  controller: _scrollController,
          padding: const EdgeInsets.all(10),
          itemCount: productsManager.getCount,
          itemBuilder: ((context, index) =>
              PostItemCard(productsManager.posts[index])),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75));
    });
  }
}
