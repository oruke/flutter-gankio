import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gankio/model/gankio.dart';
import 'package:gankio/widget/artcle_detail.dart';
import 'package:gankio/widget/drawer_nav.dart';
import 'dart:io';

import 'package:optional/optional.dart';

class Article extends StatefulWidget {
  String url;
  String title;

  Article(this.url, this.title);

  @override
  State<StatefulWidget> createState() {
    return new ArticleState(url, title);
  }
}

class ArticleState extends State<StatefulWidget> {
  final articles = <GankIO>[];
  var page = 0;
  final size = 20;
  String url;
  String title;

  ArticleState(this.url, this.title);

  final _titleStyle = const TextStyle(fontSize: 18.0);
  final _smallStyle = const TextStyle(fontSize: 12.0, color: Colors.blue);

  void more() async {
    page = page + 1;
    var client = new HttpClient();

    List<GankIO> results = [];
    try {
      var request = await client.getUrl(Uri.parse(url+size.toString()+"/"+page.toString()));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var result = await response.transform(UTF8.decoder).join();
        var data = json.decode(result);
        List<Object> resul= json.decode(json.encode(data['results']));
        resul.forEach((obj) {
          Map<String, dynamic> map = json.decode(json.encode(obj));
          var gankIO = new GankIO.fromJson(map);
          results.add(gankIO);
        });
      }
    } catch (exception) {
      results = [];
    }

    setState(() {
      articles.addAll(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    more();
    return new Scaffold(
      drawer: new Drawer(
        child: new DrawerNav(),
      ),
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new ListView(
        children: articles.map((gankIO) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                return new ArticleDetail(gankIO.url, gankIO.desc);
              }));
            },
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new Text(gankIO.desc == null ? "" : gankIO.desc, style: _titleStyle, textAlign: TextAlign.left,),
                  new ListTile(
                    title: new Text(gankIO.who == null ? "" : gankIO.who, style: _smallStyle,),
                    trailing: new Text(gankIO.createdAt == null ? "" : gankIO.createdAt, style: _smallStyle,),
                  )
                ],
              ),
            )
          );
        }).toList(),
      ),
    );
  }
}
