import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../models/post.dart';
import '../../services/posts_service.dart';
import '../../models/auth_token.dart';

class ProductsManager with ChangeNotifier {
  List<Post> _items = [
    // Post(id: '1',title:'Bai post moi' , id_user: '1', img_post: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg', dateTime: '2002-12-1'),
    // Post(id: '1',title:'Bai post moi' , id_user: '1', img_post: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg', dateTime: '2002-12-1'),
    // Post(id: '1',title:'Bai post moi' , id_user: '1', img_post: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg', dateTime:  '2002-12-1')
  ];
  final PostsService _postsService;

  ProductsManager([AuthToken? authToken])
      : _postsService = PostsService(authToken);

  int get postOrder {
    return _items.length;
  }

  set authToken(AuthToken? authToken) {
    _postsService.authToken = authToken;
  }

  List<Post> get posts {
    return [..._items];
  }

  void addPost(Post newPost) {
    _items.add(newPost.copyWith(id: 'p${DateTime.now().toIso8601String()}'));
    notifyListeners();
  }

  Future<void> isLike(String id_post) async {
    // print('id post:${id_post}');
    await _postsService.isLike(id_post);

    // notifyListeners();

    // _items.forEach((element) {

    //  if(id_post == element.id){
    //       var a =   element.like;
    //       final productsMap = json.encode(a) ;
    //         var  b =  json.decode(productsMap) ;
    //         b['id_user'].forEach((ele) =>{
    //               if(ele=='633d07aca450d61d479788f1'){

    //               }

    //         }

    //         );

    //  }
    // });
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _postsService.fetchProducts();
    // print(_items);
    notifyListeners();
  }

  Future<void> fetchProductsSingle([bool filterByUser = false]) async {
    _items = await _postsService.fetchProductsSingle();
    // print(_items);
    notifyListeners();
  }

  Future<void> fetchProductsFriend(String? id) async {
    print('lan2 ${id}');

    _items = await _postsService.fetchProductsFriend(id);
    notifyListeners();
  }

  Future<void> upPost(String title, String imgUrl, int public, String id_user,
      String day) async {
    await _postsService.upPost(title, imgUrl, public, id_user, day);
    // print(_items);
    notifyListeners();
  }

  Future<void> deletePost(String id) async {
    print('dang xoa');
    await _postsService.deletePost(id);
    // print(_items);
    notifyListeners();
  }

  Future<String> changeName(String name) async {
    print('change name');
    var a = await _postsService.changeName(name);
    return a;
  }

  int get getCount {
    return _items.length;
  }

  Future<String> changeAvatar(String img) async {
    print('change Avatar');
    var a = await _postsService.changeAvatar(img);
    return a;
  }
}
