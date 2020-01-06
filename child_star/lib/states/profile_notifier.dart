import 'package:child_star/common/global.dart';
import 'package:child_star/models/index.dart';
import 'package:flutter/widgets.dart';

class ProfileProvider extends ChangeNotifier {
  Profile get _profile => Global.profile;
  bool get isFirst => Global.profile.isFirst ?? true;

  set first(bool isFirst) {
    _profile.isFirst = isFirst;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserProvider extends ProfileProvider {
  User get user => _profile.user;

  bool get isLogin => user != null;

  set token(String token) {
    _profile.token = token;
    notifyListeners();
  }

  set user(User user) {
    _profile.user = user;
    notifyListeners();
  }
}

class FollowProvider extends ChangeNotifier {
  bool _isConcern;

  bool get isConcern => _isConcern;

  set isConcern(bool isConcern) {
    _isConcern = isConcern;
    notifyListeners();
  }

  reset() {
    _isConcern = null;
  }
}
