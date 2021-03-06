import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/api_exceptions.dart';

class ApiBaseHelper {
  final String baseUrl;
  final http.Client client;

  ApiBaseHelper({
    @required this.baseUrl,
    @required this.client,
  });

  Future<Map<String, String>> _prepareHeaders() async {
    String bearerToken = await _getAuthTokenFromLocalCache();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    return headers;
  }

  Future<String> _getAuthTokenFromLocalCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? "";
    return token;
  }

  Future<String> get(String url) async {
    http.Response response;
    var headers = await _prepareHeaders();
    try {
      response = await client.get(
        Uri.parse(baseUrl + url),
        headers: headers,
      );
      _checkResponseStatus(response);
    } on SocketException {
      throw ApiException('Connection failed.');
    } on http.ClientException {
      throw ApiException('Connection failed.');
    }
    return response.body;
  }

  Future<String> post(String url, {Object data}) async {
    http.Response response;
    var headers = await _prepareHeaders();
    try {
      response = await client.post(
        Uri.parse(baseUrl + url),
        body: data is String ? data : json.encode(data),
        headers: headers,
      );
      _checkResponseStatus(response);
    } on SocketException {
      throw ApiException('Connection failed.');
    } on http.ClientException {
      throw ApiException('Connection failed.');
    }
    return response.body;
  }

  Future<String> delete(String url) async {
    http.Response response;
    var headers = await _prepareHeaders();
    try {
      response = await client.delete(
        Uri.parse(baseUrl + url),
        headers: headers,
      );
      _checkResponseStatus(response);
    } on SocketException {
      throw ApiException('Connection failed.');
    } on http.ClientException {
      throw ApiException('Connection failed.');
    }
    return response.body;
  }

  Future<String> uploadFileMultipart(String url,
      {String fieldName, String filePath}) async {
    http.Response response;
    try {
      Map<String, String> headers = await _prepareHeaders();
      headers.remove('Content-Type');

      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + url),
      );
      try {
        http.MultipartFile file =
            await http.MultipartFile.fromPath(fieldName, filePath);
        request.files.add(file);
      } on UnsupportedError {
        print('Api -> Image Upload Not Supported On Web');
      }

      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);

      _checkResponseStatus(response);
    } on SocketException {
      throw ApiException('Connection failed!');
    } on http.ClientException {
      throw ApiException('Connection failed.');
    }
    return response.body;
  }

  _checkResponseStatus(http.Response response) {
    var _response = json.decode(response.body);
    final int _code = response.statusCode;
    switch (_code) {
      case 200:
      case 201:
        return;
      case 400:
        throw BadRequestException(_response['message']);
      case 401:
      case 403:
        throw UnauthorizedException(_response['message']);
      case 404:
        throw ResourceNotFoundException(_response['message']);
      case 422:
        throw InvalidInputException(_response['errors'], _response['message']);
      case 500:
        throw ApiException('Error with StatusCode: $_code');
    }
  }
}
