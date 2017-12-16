import 'package:flutter_oauth/lib/model/config.dart';

class TokenRequestDetails {

  String url;
  Map<String, String> params;
  Map<String, String> headers;

  TokenRequestDetails(Config configuration, String code) {
    this.url = configuration.tokenUrl;
    this.params = {
      "client_id": configuration.clientId,
      "client_secret": configuration.clientSecret,
      "code": code,
      "redirect_uri": configuration.redirectUri,
      "grant_type": "authorization_code"
    };

    //some api like weibo need this.
    final queryParams = <String>[];
    this.params.forEach((key,value)=>queryParams.add("$key=$value"));
    this.url += "?" + queryParams.join("&");

    this.headers = {
      "Accept": "application/json",
      "Content-Type": configuration.contentType
    };
    if (configuration.headers != null) {
      this.headers.addAll(headers);
    }
  }

}