import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/post/posts_grid.dart';
import 'package:provider/provider.dart';
import './post_manager.dart';

class PostsOverviewScreen extends StatefulWidget {
  static const routeName = '/post';
  const PostsOverviewScreen({super.key});
  @override
  State<PostsOverviewScreen> createState() => _PostsOverviewScreenState();
}

class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
  // final _showOnlyFavorites = ValueNotifier<bool>(false) ;
  late Future<void> _fetchProducts;

  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PostsGrid();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
