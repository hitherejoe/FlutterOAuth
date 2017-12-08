class Token {

  String accessToken;
  String tokenType;

  Token();

  factory Token.fromJson(Map<String, String> json) =>
      Token.fromMap(json);

  Map toMap() => Token.toJsonMap(this);

  @override
  String toString() => Token.toJsonMap(this).toString();

  static Map toJsonMap(Token model) {
    Map ret = new Map();
    if (model != null) {
      if (model.accessToken != null) {
        ret["access_token"] = model.accessToken;
      }
      if (model.tokenType != null) {
        ret["token_type"] = model.tokenType;
      }
    }
    return ret;
  }

  static Token fromMap(Map map) {
    if (map == null) return null;
    Token model = new Token();
    model.accessToken = map["access_token"];
    model.tokenType = map["token_type"];
    return model;
  }

}