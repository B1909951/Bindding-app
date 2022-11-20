import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poster/ui/auth/auth_manager.dart';
import './user_post_item_card.dart';
import './post_manager.dart';
import '../../models/post.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserPostsGrid1 extends StatefulWidget {
  @override
  State<UserPostsGrid1> createState() => _UserPostGridState();
}

class _UserPostGridState extends State<UserPostsGrid1> {
  String? image;
  XFile? i;
  String? anh;
  File? tmp;
  bool isEdit = false;
  ScrollController controller = ScrollController();
  var _userController = TextEditingController();
  void initState() {
    super.initState();
    controller.addListener(() {
      // always prints "scrolling = true"
      print('scrolling = ${controller.position.isScrollingNotifier.value}');
    });
    // controller = ScrollController()..addListener(_scrollListener);
  }

  setName() async {
    var name = _userController.text;
    if (name == '') {
      print('object');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text(
              'Tên không được rỗng',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
    } else {
      var a = await context.read<ProductsManager>().changeName(name);

      context.read<AuthManager>().setName = a;
      context.read<ProductsManager>().fetchProductsSingle();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text(
              'Cập nhật thành công',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter > 500) {
      print('cuoi trang roi');
    }
  }

  void setEdit() {
    isEdit = !isEdit;
  }

  Future pickImageGallery() async {
    i = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (i != null) {
      tmp = File(i!.path);
      image = i!.path;
      print(i!.name);

      var uri =
          Uri.parse('http://${dotenv.env["HOST"]}:3000/api/post/uploadfile');

      var request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
          'file', File(tmp!.path).readAsBytesSync(),
          filename: tmp!.path));

      var response = await request.send();
      print(response.statusCode);
      Future<String>? avatar;

      avatar = context.read<ProductsManager>().changeAvatar(i!.name);
      print(avatar);

      avatar.then((value) => {
            context.read<AuthManager>().setAvatar = value,
            context.read<ProductsManager>().fetchProductsSingle()
          });
    }
  }

  Future<void> postImage(String? id) async {
    ///////////////////
  }

  Widget build(BuildContext context) {
    var a = context.read<AuthManager>().authToken?.avatar;

    var name = context.read<AuthManager>().authToken?.name;
    return Consumer<ProductsManager>(
        builder: (context, productsManager, child) {
      return Column(
        children: [
          AuthorCard(a, name),
          Expanded(
              child: GridView.builder(
            //  controller: _scrollController,
            padding: const EdgeInsets.all(10),
            itemCount: productsManager.getCount,
            itemBuilder: ((context, index) =>
                UserPostItemCard(productsManager.posts[index])),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75),
          ))
        ],
      );
    });
  }

  Widget AuthorCard(String? a, String? name) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  radius: 5,
                  backgroundImage: NetworkImage(
                      'http://${dotenv.env['HOST']}:3000/image/${a}'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    tooltip: 'Change Avatar',
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      pickImageGallery();
                    },
                  ))
            ],
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isEdit
                      ? Expanded(
                          child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _userController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'User Name',
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () => {
                                      setState(() {
                                        setName();
                                        setEdit();
                                      })
                                    },
                                icon: Icon(Icons.add))
                          ],
                        ))
                      : Row(
                          children: [
                            Text(
                              name!,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            IconButton(
                                onPressed: () => {
                                      setState(() => {setEdit()})
                                    },
                                icon: Icon(Icons.edit))
                          ],
                        )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
