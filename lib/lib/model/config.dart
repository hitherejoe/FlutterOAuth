class Config {
  final String authorizationUrl;
  final String tokenUrl;
  final String clientId;
  final String clientSecret;
  final String redirectUri;
  final String responseType;
  final String contentType;
  final Map<String, String> parameters;
  final Map<String, String> headers;

  Config(this.authorizationUrl, this.tokenUrl, this.clientId,
      this.clientSecret, this.redirectUri, this.responseType,
      {this.contentType = "application/json", this.parameters, this.headers});
}