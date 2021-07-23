/// albumId : 1
/// id : 1
/// title : "accusamus beatae ad facilis cum similique qui sunt"
/// url : "https://via.placeholder.com/600/92c952"
/// thumbnailUrl : "https://via.placeholder.com/150/92c952"

class User {
  String? _albumId;
  String? _id;
  String? _title;
  String? _url;
  String? _thumbnailUrl;

  String? get albumId => _albumId;
  String? get id => _id;
  String? get title => _title;
  String? get url => _url;
  String? get thumbnailUrl => _thumbnailUrl;

  User.fromJson(dynamic json) {
    _albumId = json["albumId"].toString();
    _id = json["id"].toString();
    _title = json["title"];
    _url = json["url"];
    _thumbnailUrl = json["thumbnailUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["albumId"] = _albumId;
    map["id"] = _id;
    map["title"] = _title;
    map["url"] = _url;
    map["thumbnailUrl"] = _thumbnailUrl;
    return map;
  }

  static List<User> parseList(List<dynamic> list) {
    return list.map((e) => User.fromJson(e)).toList();
  }

  // static List<Photo> parseList(List<dynamic> list) {
  //   return list.map((i) => Photo.fromJson(i)).toList();
  // }

}
