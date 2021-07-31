import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../child/models/child_model.dart';
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
    bool remoteSuccess = await _deleteTokenFromRemote();
    bool localSuccess = await _deleteTokenFromLocalCache();

    return remoteSuccess && localSuccess;
  }

  Future<bool> generateOtp(String phoneNo) async {
    try {
      String jsonResponse = await _apiBaseHelper.post(
        '/otp/generate',
        data: {'phone_no': phoneNo},
      );
      print(jsonResponse);
    } on ApiException {
      rethrow;
    } catch (e) {
      print("AuthRepository -> " + e.toString());
      return false;
    }
    return true;
  }

  Future<List<Child>> loginChild(String phoneNo, String otp) async {
    List<Child> children;
    try {
      String jsonResponse = await _apiBaseHelper.post(
        '/children/login',
        data: {'phone_no': phoneNo, 'otp': otp},
      );
      children = (json.decode(jsonResponse) as List)
          .map((child) => Child.fromMap(child))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      print("ChildRepository -> " + e.toString());
    }
    return children;
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
    return await prefs.remove('auth_token');
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
