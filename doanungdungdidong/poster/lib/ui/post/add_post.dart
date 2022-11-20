import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:poster/ui/post/post_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poster/ui/auth/auth_manager.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key});
  static const routeName = '/add-post';

  State<AddPost> createState() => AddPostState();
}

class AddPostState extends State<AddPost> {
  String? image;
  XFile? i;

  File? tmp;
  final _contentController = TextEditingController();
  Future<int> postImage(String? id) async {
    // THONG TIN
    String day = '${DateTime.now()}';

    var title = _contentController.text;
    print('title $title');

    if (title == '') {
      title = '.';
      print('title rong');
    }
    var public = 0;
    var imgUrl = i?.name;
    var id_user = id;
    print('id la ${id_user}');
    if (imgUrl == null) {
      return 0;
    } else {
      await context
          .read<ProductsManager>()
          .upPost(title, imgUrl, public, id_user!, day);
      // ///////////////////

      var uri =
          Uri.parse('http://${dotenv.env["HOST"]}:3000/api/post/uploadfile');

      var request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
          'file', File(tmp!.path).readAsBytesSync(),
          filename: tmp!.path));

      var response = await request.send();
      print(response.statusCode);
    }
    return 1;
  }

  Future pickImage() async {
    i = await ImagePicker().pickImage(source: ImageSource.camera);

    if (i != null) {
      image = i!.path;
      print(image);
      tmp = File(i!.path);
      File tmpFile = File(i!.path);
      tmpFile = await tmpFile.copy(tmpFile.path);
      setState(() {});
    }
  }

  Future pickImageGallery() async {
    i = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (i != null) {
      tmp = File(i!.path);
      image = i!.path;
      print(image);
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    var auid = context.read<AuthManager>().authToken;
    return Container(
        child: SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 8.0,
        ),
        Text(
          'Đăng Bài Viết',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Hôm nay bạn thế nào?',
            ),
            controller: _contentController,
            // cursorColor: Color.fromARGB(147, 115, 156, 217),
            cursorRadius: Radius.circular(16.0),
            // cursorWidth: 16.0,
            maxLines: null,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 18),
        image == null
            ? Container(
                height: 300,
                width: 300,
                color: Color.fromARGB(147, 115, 156, 217),
              )
            : SizedBox(
                height: 300,
                child: SingleChildScrollView(
                    child: Image.file(File(image!).absolute))),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => {
                      pickImage(),
                    },
                child: Icon(Icons.camera)),
            const SizedBox(width: 40),
            ElevatedButton(
                onPressed: () => {pickImageGallery()}, child: Icon(Icons.image))
          ],
        ),
        SizedBox(height: 12),
        ElevatedButton(
            onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Are you sure? '),
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
                            var i = postImage(auid?.user_id);
                            i.then((value) => {
                                  if (value == 1)
                                    {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'Đăng thành công',
                                            ),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        )
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'Đăng thất bại',
                                            ),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        )
                                    }
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                },
            child: Text('Đăng bài'))
      ]),
    ));
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
