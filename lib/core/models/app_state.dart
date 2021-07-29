import 'package:shared_preferences/shared_preferences.dart';

import '../../child/models/child_model.dart';

class AppState {
  bool _isLoggedIn;
  List<Child> _children;

  bool get isLoggedIn => _isLoggedIn;
  List<Child> get children => _children;

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
  }

  void setChildren(List<Child> children) {
    _children = children;
  }

  Future<void> loadStateFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.containsKey('auth_token');
  }
}
