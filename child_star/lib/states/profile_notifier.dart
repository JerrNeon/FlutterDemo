import 'package:child_star/common/global.dart';
import 'package:child_star/models/index.dart';
import 'package:flutter/widgets.dart';

class ProfileNotifierProvider extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserProvider extends ProfileNotifierProvider {
  User get user => _profile.user;

  bool get isLogin => user != null;

  set user(User user) {
    _profile.user = user;
    notifyListeners();
  }
}
