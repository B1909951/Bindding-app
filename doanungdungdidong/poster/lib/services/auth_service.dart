import 'dart:convert';

import 'package:poster/models/auth_token.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/post.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<AuthToken> _authenticate(String username, String password) async {
    try {
// final filters =filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      print('thu xem lao ${dotenv.env['HOST']}');
      final url = Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/login');

      var response = await http.post(url,
          body: json.encode({
            'user': username,
            'pass': password,
          }),
          headers: {"Content-Type": "application/json"});

      final productsMap = json.decode(response.body) as Map<String, dynamic>;
      print('hello ae ${productsMap['token']}');
      print(productsMap['avatar']);
      if (productsMap.length == 0) {
        return AuthToken(token: null);
      }
// print(productsMap);
      return AuthToken(
          token: productsMap['token'],
          userId: productsMap['id'],
          name: productsMap['name'],
          avatar: productsMap['avatar']);

// return productsMap;
    } catch (error) {
      print('hahahahah $error');
      rethrow;
    }
  }

  Future<String> xulydangky(
      String username, String user, String password) async {
    try {
// final filters =filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

      print('xu ly dang ky ${dotenv.env['HOST']}');
      final url =
          Uri.parse('http://${dotenv.env['HOST']}:3000/api/post/createUser');

      var response = await http.post(url,
          body: json.encode({
            'username': username,
            'name': user,
            'password': password,
          }),
          headers: {"Content-Type": "application/json"});
      print('res ${response.body}');
      return response.body;
// final productsMap =json.decode(response.body) as Map<String,dynamic> ;

//     print('hello ae ${productsMap['token']}');
//     print(productsMap['avatar']);
//     if(productsMap.length==0){
//         return  AuthToken(token: null);
//     }
// // print(productsMap);
//     return  AuthToken(token: productsMap['token'],userId: productsMap['id'],name: productsMap['name'],avatar: productsMap['avatar']);

// return productsMap;
    } catch (error) {
      print('hahahahah $error');
      rethrow;
    }
  }

  Future<AuthToken> login(String email, String password) {
    return _authenticate(email, password);
  }

  Future<String> signup(String username, String user, String password) {
    return xulydangky(username, user, password);
  }
}
