import 'package:flutter/material.dart';

class ImageDetail extends StatelessWidget {
  String src;
  String title;

  ImageDetail(this.src, this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Container(
        child: new Image.network(
          src
        ),
      ),
    );
  }
}