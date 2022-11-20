class AuthToken {
  final String _token;
  final String _userId;
  String _name;
  String _avatar;

  AuthToken({token, userId, name, avatar
      // userId,

      })
      : _token = token,
        _userId = userId,
        _name = name,
        _avatar = avatar
  // _userId = userId
  ;

  bool get isValid {
    return token != null;
  }

  String? get token {
    return _token;
  }

  String? get user_id {
    return _userId;
  }

  String? get name {
    return _name;
  }

  String? get avatar {
    return _avatar;
  }

  void set setAvatar(String avatar) {
    _avatar = avatar;
  }

  void set setName(String name) {
    _name = name;
  }
  // String get userId {
  //   return _userId;
  // }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      // 'userId': _userId,
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      // userId: json['userId'],
    );
  }
}
