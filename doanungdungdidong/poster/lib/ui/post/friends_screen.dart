import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/post/friends_posts_grid.dart';
import 'package:provider/provider.dart';
import './post_manager.dart';

class FriendScreen extends StatefulWidget {
  static const routeName = '/friend';
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  // final _showOnlyFavorites = ValueNotifier<bool>(false) ;
  // late Future<void> _fetchProducts;

  void initState() {
    super.initState();
    // _fetchProducts = context.read<ProductsManager>().fetchProductsFriend();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushReplacementNamed('/post');
              }),
              icon: Icon(Icons.arrow_back_sharp)),
          Text('Profile')
        ],
      )),

      body:

          //  FutureBuilder(
          //   future: _fetchProducts,
          //   builder: (context, snapshot) {
          //   if (snapshot.connectionState == ConnectionState.done) {

          FriendPostsGrid(),

      // }
      // return const Center(
      // child: CircularProgressIndicator(),
      // );
      // },
      // )
    );
  }
//         Widget AuthorCard(){

//         return Container(
//         color: Colors.red,
//         width: double.infinity,
//         padding: EdgeInsets.all(8.0),
//           child:  Column(

//                 crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//                Stack(
//               children: [
//   SizedBox(

//                 height: 80,
//                 width: 80,

//                 child:   CircleAvatar(

//                   radius: 5,
//                   backgroundImage: AssetImage('sandwichgagion_nuocngot_khoaitay.png'),
//                 )

// ,
//               ),

//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child:
//               Icon(Icons.camera_alt)
//               )
//               ],
//             ),
//               const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                       Text('Phuong',
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.greenAccent
//                 ),
//               ),

//                   ],
//                 )

//             ],

//         ),
//         )
// ;

//   }
}
