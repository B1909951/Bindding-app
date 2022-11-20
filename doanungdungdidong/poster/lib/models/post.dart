class Post {
  final String? id;
  final String title;

  final String id_user;
  final String img_post;
  final String dateTime;
  final Object like;
  final Object? users;

  Post(
      {this.id,
      required this.title,
      required this.id_user,
      required this.img_post,
      required this.dateTime,
      required this.like,
      this.users});

  Post copyWith(
      {String? id,
      String? title,
      String? id_user,
      String? img_post,
      String? dateTime,
      Object? like,
      Object? users}) {
    return Post(
        id: id ?? this.id,
        title: title ?? this.title,
        id_user: id_user ?? this.id_user,
        img_post: img_post ?? this.img_post,
        dateTime: dateTime ?? this.dateTime,
        like: like ?? this.like,
        users: users ?? this.users);
  }

  Object get u {
    return users!;
  }

// static Post fromJson(Map<String,dynamic> json) {

// return Post(
// id: json['_id'],
// title: json['title'],
// id_user: json['id_user'],
// img_post: json['imgUrl'],

// );

// }

}
