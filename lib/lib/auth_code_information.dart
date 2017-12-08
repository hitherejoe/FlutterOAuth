import 'package:flutter_oauth/lib/model/config.dart';

class AuthorizationRequest {

  String url;
  Map<String, String> parameters;
  Map<String, String> headers;
  bool fullScreen;
  bool clearCookies;

  AuthorizationRequest(Config config,
      {bool fullScreen: true, bool clearCookies: true}) {
    this.url = config.authorizationUrl;
    this.parameters = {
      "client_id": config.clientId,
      "response_type": config.responseType,
      "redirect_uri": config.redirectUri,
    };
    if (config.parameters != null) {
      this.parameters.addAll(config.parameters);
    }
    this.fullScreen = fullScreen;
    this.clearCookies = clearCookies;
    this.headers = config.headers;
  }

}
