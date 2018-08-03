import 'package:flutter/material.dart';
import 'package:gankio/widget/artcle_list.dart';
import 'package:gankio/widget/image_list.dart';

class DrawerNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(accountName: null, accountEmail: null),
          new ClipRect(
            child: new ListTile(
              title: new Text("Android"),
              leading: new Icon(Icons.android),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) {
                  return new Article("http://gank.io/api/data/Android/", "Android");
                }), (Route<dynamic> route) => false);
              },
            ),
          ),
          new ClipRect(
            child: new ListTile(
              title: new Text("iOS"),
              leading: new Icon(Icons.stay_current_portrait),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) {
                  return new Article("http://gank.io/api/data/iOS/", "iOS");
                }), (Route<dynamic> route) => false);
              },
            ),
          ),
          new ClipRect(
            child: new ListTile(
              title: new Text("前端 "),
              leading: new Icon(Icons.web),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) {
                  return new Article("http://gank.io/api/data/前端/", "前端");
                }), (Route<dynamic> route) => false);
              },
            ),
          ),
          new ClipRect(
            child: new ListTile(
              title: new Text("福利 "),
              leading: new Icon(Icons.image),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context) {
                  return new ImageList();
                }), (Route<dynamic> route) => false);
              },
            ),
          ),
        ],
      );
  }

}