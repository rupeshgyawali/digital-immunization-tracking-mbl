import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/api_exceptions.dart';
import '../../core/helpers/api_base_helper.dart';
import '../models/auth_token_model.dart';

class AuthRepository {
  final ApiBaseHelper _apiBaseHelper;

  AuthRepository({
    @required apiBaseHelper,
  }) : this._apiBaseHelper = apiBaseHelper;

  Future<bool> loginHealthPersonnel(String email, String password) async {
    AuthToken authToken = await _getTokenFromRemote(email, password);
    return authToken == null ? false : await _saveAuthTokenToCache(authToken);
  }

  Future<bool> logoutHealthPersonnel() async {
    return await _deleteTokenFromLocalCache() && await _deleteTokenFromRemote()
        ? true
        : false;
  }

  //Get saved auth token from local cache
  Future<AuthToken> _getTokenFromLocalCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.get('auth_token');

    return token != null ? AuthToken(token: token) : null;
  }

  //Get auth token through api
  Future<AuthToken> _getTokenFromRemote(String email, String password) async {
    AuthToken authToken;
    try {
      String jsonResponse = await _apiBaseHelper.post(
        '/authenticate',
        data: {'email': email, 'password': password},
      );
      authToken = AuthToken.fromJson(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("AuthRepository -> " + e.toString());
      return null;
    }
    return authToken;
  }

  //Save auth token to local cache
  Future<bool> _saveAuthTokenToCache(AuthToken authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = authToken.token;
    if (token == null && token.length == 0) {
      return false;
    }
    return await prefs.setString('auth_token', token);
  }

  //Remove locally saved auth token
  Future<bool> _deleteTokenFromLocalCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('auth_token');
  }

  //Revoke currently authenticated user's auth tokens from remote
  Future<bool> _deleteTokenFromRemote() async {
    String jsonResponse;
    try {
      jsonResponse = await _apiBaseHelper.post('/logout');
      print(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("AuthRepository -> " + e.toString());
      return false;
    }
    return true;
  }
}
