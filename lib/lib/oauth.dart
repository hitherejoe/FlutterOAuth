library flutter_oauth;

import 'dart:async';
import 'dart:convert';

import 'package:flutter_oauth/lib/auth_code_information.dart';
import 'package:flutter_oauth/lib/model/config.dart';
import 'package:flutter_oauth/lib/oauth_token.dart';
import 'package:flutter_oauth/lib/token.dart';
import 'package:http/http.dart';

abstract class OAuth {

  final Config configuration;
  final AuthorizationRequest requestDetails;
  String code;
  Map<String, dynamic> token;

  TokenRequestDetails tokenRequest;

  OAuth(this.configuration, this.requestDetails);

  Future<Map<String, dynamic>> getToken() async {
    if (token == null) {
      Response response = await post("${tokenRequest.url}",
          body: JSON.encode(tokenRequest.params),
          headers: tokenRequest.headers);
      token = JSON.decode(response.body);
    }
    return token;
  }

  bool shouldRequestCode() => code == null;

  String constructUrlParams() => mapToQueryParams(requestDetails.parameters);

  String mapToQueryParams(Map<String, String> params) {
    final queryParams = <String>[];
    params
        .forEach((String key, String value) => queryParams.add("$key=$value"));
    return queryParams.join("&");
  }

  void generateTokenRequest() {
    tokenRequest = new TokenRequestDetails(configuration, code);
  }

  Future<Token> performAuthorization() async {
    String resultCode = await requestCode();
    if (resultCode != null) {
      generateTokenRequest();
      return new Token.fromJson(await getToken());
    }
    return null;
  }

  Future<String> requestCode();

}