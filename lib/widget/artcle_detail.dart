import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleDetail extends StatelessWidget {
  String url;
  String title;

  ArticleDetail(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new WebviewScaffold(
          appBar: new AppBar(
            title: new Text(title),
          ),
          url: url,
          withJavascript: true,
          withLocalStorage: true,
          withZoom: false,
        ),
      ),
    );
  }
}