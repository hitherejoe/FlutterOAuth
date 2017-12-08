import 'dart:async';
import 'dart:io';

import 'package:flutter_oauth/lib/auth_code_information.dart';
import 'package:flutter_oauth/lib/model/config.dart';
import 'package:flutter_oauth/lib/oauth.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FlutterOAuth extends OAuth {
  final StreamController<String> onCodeListener = new StreamController();

  final FlutterWebviewPlugin webView = new FlutterWebviewPlugin();

  var isBrowserOpen = false;
  var server;
  var onCodeStream;

  Stream<String> get onCode =>
      onCodeStream ??= onCodeListener.stream.asBroadcastStream();

  FlutterOAuth(Config configuration) :
        super(configuration, new AuthorizationRequest(configuration));

  Future<String> requestCode() async {
    if (shouldRequestCode() && !isBrowserOpen) {
      await webView.close();
      isBrowserOpen = true;

      server = await createServer();
      listenForServerResponse(server);

      final String urlParams = constructUrlParams();
      webView.onDestroy.first.then((_) {
        close();
      });

      webView.launch("${requestDetails.url}?$urlParams",
          clearCookies: requestDetails.clearCookies,
          fullScreen: requestDetails.fullScreen);

      code = await onCode.first;
      close();
    }
    return code;
  }

  void close() {
    if (isBrowserOpen) {
      server.close(force: true);
      webView.close();
    }
    isBrowserOpen = false;
  }

  Future<HttpServer> createServer() async {
    final server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080,
        shared: true);
    return server;
  }

  listenForServerResponse(HttpServer server) {
    server.listen((HttpRequest request) async {
      final uri = request.uri;
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.HTML.mimeType);

      final code = uri.queryParameters["code"];
      final error = uri.queryParameters["error"];
      await request.response.close();
      if (code != null && error == null) {
        onCodeListener.add(code);
      } else if (error != null) {
        onCodeListener.add(null);
        onCodeListener.addError(error);
      }
    });
  }

}