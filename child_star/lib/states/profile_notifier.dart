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

  saveProfile() {
    Global.saveProfile();
  }

  @override
  void notifyListeners() {
    saveProfile();
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

  saveUser(User user) {
    _profile.user = user;
    saveProfile();
  }
}

class FollowProvider extends ChangeNotifier {
  String _authorId;
  bool _isConcern;

  String get authorId => _authorId;

  bool get isConcern => _isConcern;

  setConcernData(String authorId, bool isConcern) {
    _authorId = authorId;
    _isConcern = isConcern;
    notifyListeners();
  }

  reset() {
    _authorId = null;
    _isConcern = null;
  }
}
