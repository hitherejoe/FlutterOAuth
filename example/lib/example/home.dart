import 'package:flutter/material.dart';
import 'package:flutter_oauth/lib/flutter_auth.dart';
import 'package:flutter_oauth/lib/model/config.dart';
import 'package:flutter_oauth/lib/oauth.dart';
import 'package:flutter_oauth/lib/token.dart';

void main() {
  runApp(new FlutterView());
}

class FlutterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter OAuth',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: new Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  MainState createState() => new MainState();
}

class MainState extends State<Main> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Center(
                child: new RaisedButton(
                  child: new Text("Authorise"),
                  onPressed: () => authorise(),
                )
            ),
          ),
        ],
      ),
    );
  }

  authorise() async {
    final OAuth flutterOAuth = new FlutterOAuth(new Config(
        "https://www.strava.com/oauth/authorize",
        "https://www.strava.com/oauth/token",
        "CLIENT_ID",
        "CLIENT_SECRET",
        "http://localhost:8080",
        "code"));
    Token token = await flutterOAuth.performAuthorization();
    var alert = new AlertDialog(
      title: new Text("Access Token"),
      content: new Text(token.accessToken),
    );
    showDialog(context: context, child: alert);
  }

}