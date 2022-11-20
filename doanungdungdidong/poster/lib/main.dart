import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './services/posts_service.dart';
import 'package:provider/provider.dart';
import 'main_post.dart';
import './ui/screens.dart';
import './ui/post/friends_screen.dart';
import './ui/auth/signup.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => AuthManager()),
          ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
            create: (ctx) => ProductsManager(),
            update: (ctx, authManager, productsManager) {
              // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
              // cho productManager
              productsManager!.authToken = authManager.authToken;
              return productsManager;
            },
          )
        ],
        child: Consumer<AuthManager>(builder: (context, authManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: authManager.isAuth ? MainPost() : Login(),
            //    MainPost() : Login(),
            routes: {
              FriendScreen.routeName: (ctx) => FriendScreen(),
              PostsOverviewScreen.routeName: (ctx) => MainPost(),
              Login.routeName: (ctx) => Login(),
              Signup.routeName: (ctx) => Signup(),
            },
            //  AddPost()
          );
        }));
  }
}
