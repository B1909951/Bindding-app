import 'package:flutter/material.dart';
import 'package:poster/ui/auth/signup.dart';
import 'package:provider/provider.dart';

import 'package:poster/models/auth_token.dart';
import 'auth_manager.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';

//  final Map<String, String> _authData = {
//     'username': '',
//     'password': '',
//   };
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Widget build(BuildContext context) {
    void getLogin() {
      var user = _userController.text;
      var password = _passController.text;

      context.read<AuthManager>().login(user, password);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Binding',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        getLogin();
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Bạn đã có tài khoản chưa?'),
                    TextButton(
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ))

        // body:Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Login',
        //         style: TextStyle(
        //           fontSize: 40
        //         ),

        //       )
        //       ,
        //         TextField(
        //           controller: _userController,

        //           textAlign: TextAlign.left,
        //           decoration: InputDecoration(

        //             hintText: 'PLEASE ENTER YOUR EMAIL',
        //             hintStyle: TextStyle(color: Colors.grey),
        //           ),
        //         ),
        //          TextField(
        //               controller: _passController,
        //               obscureText: true,
        //               textAlign: TextAlign.left,
        //               decoration: InputDecoration(

        //                 hintText: 'PLEASE ENTER YOUR EMAIL',
        //                 hintStyle: TextStyle(color: Colors.grey),
        //               ),
        //             )
        //    ,
        //         SizedBox(height: 20)
        //       ,
        //       ElevatedButton(onPressed: () => {

        //      getLogin()

        //       },

        //       child: Text('login')
        //       )
        //     ],
        //   ),
        // ),

        );
  }

  Future<bool?> showConfirmDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Are you sure? '),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              }),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
