import 'package:flutter_demo/models/user.dart';

import 'ProfileChangeNotifier.dart';

class UserModel extends ProfileChangeNotifier {
  User get user => profile.user;

  //App是否登录（如果有用户信息，则证明登录过）
  bool get isLogin => user != null;

  set user(User user) {
    if (user?.login != profile.user.login) {
      profile.lastLogin = profile.user.login;
      profile.user = user;
      notifyListeners();
    }
  }
}
