import 'package:flutter/material.dart';
import 'package:gankio/model/gankio.dart';
import 'package:gankio/widget/artcle_list.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ArticleState("http://gank.io/api/data/Android/", "Android");
  }
}