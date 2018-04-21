# Flutter OAuth

A Flutter OAuth package for performing user authentication for your apps.

I've tested this with a small collection of APIs (Buffer, Strava, Unsplash and GitHub). If there
is an issue with an API you are trying to work with, please file an issue :)

## Authorizing an application

Performing authorization for an API is straight forward using this library. In most cases you
will just be able to use the following approach:

```dart
final OAuth flutterOAuth = new FlutterOAuth(new Config(
    "https://unsplash.com/oauth/authorize",
    "https://unsplash.com/oauth/token",
    "YOUR_CLIENT_ID",
    "YOUR_CLIENT_SECRET",
    "http://localhost:8080",
    "code"));
```

This allows you to pass in an Authorization URL, Token request URL, Client ID, Client Secret,
Redirect URL and the response type. This should satisfy most requests, but if not then you can pass
in other optional parameters for:

- __contentType__ - This allows you to change the content type for the request. For example, for Spotify
API authorization you need to use "application/x-www-form-urlencoded"

```dart
final OAuth flutterOAuth = new FlutterOAuth(new Config(
    ...,
    contentType: "application/x-www-form-urlencoded"));
```

- __parameters__ - Add your own parameters that this library may not support out-of-the-box. For example,
with the GitHub API you can send a state string and scopes to gain authorization for

```dart
Map<String, String> customParameters = {"state": "SOME_RANDOM_SECURE_STRING", "scope": "public_repo"};

final OAuth flutterOAuth = new FlutterOAuth(new Config(
    ...,
    parameters: customParameters));
```

- __headers__ - Some APIs require you to send custom headers, such as an Authorization Header. Use this
parameter if you require this

```dart
Map<String, String> headers = {"Authorization": "Basic SOME_BASE_64_STRING"};

final OAuth flutterOAuth = new FlutterOAuth(new Config(
    ...,
    headers: headers));
```

Then once you have an OAuth instance, you can simply call the `performAuthorization()` method like so to retrieve a Token instance:

```dart
Token token = await flutterOAuth.performAuthorization();
String accessToken = token.accessToken;
```
    
## Installing

Add the following you your pubspec.yaml dependancies:

```yaml
dependencies:
  flutter_oauth: "^0.0.1"
```

## Thanks to

[Kevin Seqaud](https://medium.com/@segaud.kevin/facebook-oauth-login-flow-with-flutter-9adb717c9f2e) for his awesome blog post on Flutter OAuth https://medium.com/@segaud.kevin/facebook-oauth-login-flow-with-flutter-9adb717c9f2e

The author, [Hadrien Lejard](https://twitter.com/hadrienlejard), behind the:

The [Gitter-Dart repo](https://github.com/dart-flitter/gitter_dart), where a lot of this library was influenced

and the [Flutter Webview plugin](https://github.com/dart-flitter/flutter_webview_plugin), which this library uses
