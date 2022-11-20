import 'dart:convert';

import '../models/post.dart';
import 'package:http/http.dart' as http;
import '../models/auth_token.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostsService {
  PostsService([this.authToken]);

  AuthToken? authToken;

  Future<List<Post>> fetchProducts() async {
    final List<Post> _item = [];

    try {
// final filters =filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      final productsUrl =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/1');

      final response = await http.get(productsUrl);

      final productsMap = json.decode(response.body) as List<dynamic>;
// print(productsMap);
      productsMap.forEach((element) {
        print('users ${element}');
        _item.add(Post(
            id: element['_id'],
            title: element['title'],
            id_user: element['id_user'],
            img_post: element['imgUrl'],
            dateTime: element['Day'],
            like: element['like'],
            users: element['users'][0]));
        // print(element['title']);
      });

      return _item;

// return productsMap;
    } catch (error) {
      print('hahahahah $error');

      return _item;
    }
  }

  Future<List<Post>> fetchProductsSingle() async {
    final List<Post> _item = [];

    try {
// final filters =filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      final productsUrl =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/single/1');

      var token = authToken?.token;

      final response =
          await http.get(productsUrl, headers: {"Authorization": token!});

      final productsMap = json.decode(response.body) as List<dynamic>;

      productsMap.forEach((element) {
        print('users ${element['users'][0]}');

        _item.add(Post(
            id: element['_id'],
            title: element['title'],
            id_user: element['id_user'],
            img_post: element['imgUrl'],
            dateTime: element['Day'],
            like: element['like'],
            users: element['users']));
        // print(element['title']);
      });

      return _item;

// return productsMap;
    } catch (error) {
      print('hahahahah $error');

      return _item;
    }
  }

  Future<List<Post>> fetchProductsFriend(String? id) async {
    final List<Post> _item = [];

    try {
// final filters =filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      print(id);
      final productsUrl = Uri.parse(
          'http://${dotenv.env['HOST']}:3000/api/post/friend/1/?id_user=${id}');

      final response = await http.get(productsUrl);

      final productsMap = json.decode(response.body) as List<dynamic>;
// print(productsMap);
      productsMap.forEach((element) {
        print('users ${element}');
        _item.add(Post(
            id: element['_id'],
            title: element['title'],
            id_user: element['id_user'],
            img_post: element['imgUrl'],
            dateTime: element['Day'],
            like: element['like'],
            users: element['users'][0]));
        // print(element['title']);
      });

      return _item;

// return productsMap;
    } catch (error) {
      print('hahahahah $error');

      return _item;
    }
  }

  isLike(id_post) async {
    print('--------em--------');
    // print('auth token la : ${authToken}');
    try {
      String js = '{"id_user": "${authToken!.token}"}';

      final url = Uri.parse(
          'http://${dotenv.env['HOST']}:3000/api/post/update/${id_post}');

      var response = await http
          .put(url, body: js, headers: {"Content-Type": "application/json"});

      print('heheheheh ${response}');

// print(productsMap);

// return productsMap;
    } catch (error) {
      print('hahahahah $error');
    }
  }

  upPost(String title, String imgUrl, int public, String id_user,
      String day) async {
    print('--------em--------');
    var token = authToken?.token;
    // print('auth token la : ${authToken}');
    try {
      final url = Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/');

      var response = await http.post(url,
          body: json.encode({
            'title': title,
            'imgUrl': imgUrl,
            'public': public,
            'id_user': id_user,
            'Day': day
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token!
          });

// final productsMap =json.decode(response.body) as Map<String,dynamic> ;
      // print('hello ae ${productsMap['token']}');
//     if(productsMap.length==0){
//         return  AuthToken(token: null);
//     }
// // print(productsMap);
//     return  AuthToken(token: productsMap['token'],userId: productsMap['id']);

    } catch (error) {
      print('hahahahah $error');
    }
  }

  deletePost(String id) async {
    print('--------xoa nge--------');
    var token = authToken?.token;
    // print('auth token la : ${authToken}');
    try {
      final url =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/delete');

      var response = await http.delete(url,
          body: json.encode({
            'id_post': id,
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token!
          });

      print(response);
// final productsMap =json.decode(response.body) as Map<String,dynamic> ;
//     print('hello ae ${productsMap['token']}');
// //     if(productsMap.length==0){
//         return  AuthToken(token: null);
//     }
// // print(productsMap);
//     return  AuthToken(token: productsMap['token'],userId: productsMap['id']);

    } catch (error) {
      print('hahahahah $error');
    }
  }

  Future<String> changeAvatar(String img) async {
    try {
      print('lan 2 change avatar');
      var token = authToken?.token;

// print('thu xem lao ${dotenv.env['HOST']}');
      final url =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/update/avatar');

      var response = await http.put(url,
          body: json.encode({'imgUrl': img}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token!
          });
      print(response.body);

      return response.body;
    } catch (e) {
      print('hahahahah $e');
      rethrow;
    }
  }

  Future<String> changeName(String name) async {
    try {
      print('lan 2 change avatar');
      var token = authToken?.token;

// print('thu xem lao ${dotenv.env['HOST']}');
      final url =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/update/name');

      var response = await http.put(url,
          body: json.encode({'name': name}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": token!
          });
      print(response.body);

      return response.body;
    } catch (e) {
      print('hahahahah $e');
      rethrow;
    }
  }
}
