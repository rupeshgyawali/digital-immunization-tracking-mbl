import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;

  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
  }

  Future<void> loadStateFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.containsKey('auth_token');
  }
}
