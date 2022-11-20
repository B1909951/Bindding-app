import 'package:flutter/material.dart';
import 'package:poster/ui/auth/login.dart';
import 'package:provider/provider.dart';

import 'package:poster/models/auth_token.dart';
import 'auth_manager.dart';

class Signup extends StatelessWidget {
  static const routeName = '/Signup';

//  final Map<String, String> _authData = {
//     'username': '',
//     'password': '',
//   };
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _usernameController = TextEditingController();
  final _repassController = TextEditingController();

  Future<String> submit(BuildContext context) async {
    var isSubmit = validate(_usernameController.text, _userController.text,
        _passController.text, _repassController.text);
    if (isSubmit) {
      var res = await context.read<AuthManager>().signup(
          _usernameController.text, _userController.text, _passController.text);
      if (res == '1') {
        return '1';
      } else {
        return '2';
      }
    } else {
      return '0';
    }
  }

  bool validate(String username, String user, String pass, String repass) {
    if (username.length < 6 ||
        user.length == 0 ||
        pass != repass ||
        pass.length < 8) {
      return false;
    }

    return true;
  }

  Widget build(BuildContext context) {
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
                      'Đăng ký',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: _repassController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nhập lại Password',
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
                      child: const Text('Sign up'),
                      onPressed: () async {
                        var a;
                        await submit(context).then((value) => a = value);
                        print('a $a');
                        if (a == '1') {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Đăng ký thành công',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        } else if (a == '0') {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Thông tin không hợp lệ',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Tên tài khoản đã tồn tại',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                        }
                        // print(nameController.text);
                        // print(passwordController.text);
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Bạn đã có tài khoản chưa?'),
                    TextButton(
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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
