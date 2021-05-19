import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_token_model.dart';

class AuthRepository {
  final http.Client _apiClient;

  AuthRepository({
    @required apiClient,
  }) : this._apiClient = apiClient;

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
      http.Response response = await _apiClient.post(
          Uri.parse('http://localhost:8000/api/authenticate'),
          body: {'email': email, 'password': password},
          headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        authToken = AuthToken.fromJson(response.body);
      }
    } catch (e) {
      print(e);
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
    http.Response response;
    try {
      AuthToken authToken = await _getTokenFromLocalCache();
      response = await _apiClient
          .post(Uri.parse('http://localhost:8000/api/logout'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + authToken.token
      });
      print(response.body);
    } catch (e) {
      print(e);
      return false;
    }
    return response.statusCode == 200 ? true : false;
  }
}
