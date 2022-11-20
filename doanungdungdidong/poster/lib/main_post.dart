import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/auth/auth_manager.dart';
import 'ui/post/user_screen.dart';
import 'package:provider/provider.dart';

import 'ui/post/posts_overview_screen.dart';
import 'ui/post/add_post.dart';

class MainPost extends StatelessWidget {
  static const routeName = '/main-post';
  const MainPost({super.key});

  Widget build(BuildContext context) {
    Future<void> logout() async {
      print('logout');
      context.read<AuthManager>().logout();
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Bindding'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.post_add)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (value) => {
                      Navigator.of(context).pushReplacementNamed('/'),
                      logout(),
                    },
                icon: const Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Đăng xuất'),
                      ),
                    ])
          ],
        ),
        body: const TabBarView(
          children: [
            PostsOverviewScreen(),
            AddPost(),
            UserScreen(),
          ],
        ),
      ),
    );
  }
}
