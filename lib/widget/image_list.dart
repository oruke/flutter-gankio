import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gankio/model/gankio.dart';
import 'package:gankio/widget/drawer_nav.dart';
import 'package:gankio/widget/image_detail.dart';

class ImageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ImageListState();
  }
}

class ImageListState extends State<StatefulWidget> {
  final articles = <GankIO>[];
  var page = 0;
  final size = 20;
  String url = "http://gank.io/api/data/福利/";
  String title = "福利";

  final _titleStyle = const TextStyle(fontSize: 18.0);
  final _smallStyle = const TextStyle(fontSize: 12.0);

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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    more();
    return new Scaffold(
      drawer: new Drawer(
        child: new DrawerNav(),
      ),
      appBar: new AppBar(
        title: new Text(title),
        centerTitle: true,
      ),
      body: new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        children: articles.map((gankIO) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                  return new ImageDetail(gankIO.url, gankIO.desc);
                }));
              },
              child: new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Image.network(
                      gankIO.url,
                      width: itemWidth,
                    ),
                    new Text(gankIO.desc, style: _smallStyle,)
                  ],
                ),
              )
          );
        }).toList(),
      ),
    );
  }
}