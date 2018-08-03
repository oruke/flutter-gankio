
class GankIO {
  String createdAt;
  String desc;
  List<Object> images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  GankIO();

  GankIO.fromJson(Map<String, dynamic> json) {
    this.createdAt = json['createdAt'];
    this.desc = json['desc'];
    this.images = json['images'];
    this.publishedAt = json['publishedAt'];
    this.source = json['source'];
    this.type = json['type'];
    this.url = json['url'];
    this.used = json['used'];
    this.who = json['who'];
  }
}