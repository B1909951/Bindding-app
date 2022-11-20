import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../models/auth_token.dart';
import '../../services/auth_service.dart';

class AuthManager with ChangeNotifier {
  AuthToken? _authToken;

  final AuthService _authService = AuthService();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  AuthToken? get authToken {
    return _authToken;
  }

  void set setAvatar(String avatar) {
    _authToken?.setAvatar = avatar;
    notifyListeners();
  }

  void set setName(String name) {
    _authToken?.setName = name;
    notifyListeners();
  }

  void _setAuthToken(AuthToken token) {
    _authToken = token;
    print('he hai ${token}');
    // _autoLogout();
    notifyListeners();
  }

  // Future<void> signup(String email, String password) async {
  //   _setAuthToken(await _authService.signup(email, password));
  // }

  Future<void> login(String email, String password) async {
    _setAuthToken(await _authService.login(email, password));
    notifyListeners();
  }

  Future<String> signup(String username, String user, String password) async {
    var res = await _authService.signup(username, user, password);
    return res;
  }

  // Future<bool> tryAutoLogin() async {
  //   final savedToken = await _authService.loadSavedAuthToken();
  //   if (savedToken == null) {
  //     return false;
  //   }

  //   _setAuthToken(savedToken);
  //   return true;
  // }

  Future<void> logout() async {
    _authToken = null;

    notifyListeners();
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer!.cancel();
  //   }
  //   final timeToExpiry =
  //       _authToken!.expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
