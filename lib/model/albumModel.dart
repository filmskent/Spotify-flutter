class Album {
  String? _url;
  String? _name;
  String? _artist;
  String? _id;

  Album({
    String? url,
    String? name,
    String? artist,
    String? id,
  }) {
    this._url = url;
    this._name = name;
    this._artist = artist;
    this._id = id;
  }

  Album.fromJson(Map<String, dynamic> json) {
    _url = json['images'][1]["url"];
    _name = json['name'] as String?;
    _artist = json['artists'][0]['name'];
    _id = json['id'];
  }

  String? get url => _url;
  set url(String? url) => _url = url;

  String? get name => _name;
  set name(String? name) => _name = name;

  String? get artist => _artist;
  set artist(String? artist) => _artist = artist;

  String? get id => _id;
  set id(String? id) => _id = id;
}

class AlbumDetail {
  String? _url;
  String? _name;
  String? _artist;
  String? _id;
  String? _genre;
  List<Song>? _songList;

  AlbumDetail({
    String? url,
    String? name,
    String? artist,
    String? id,
    String? genre,
    List<Song>? songList,
  }) {
    this._url = url;
    this._name = name;
    this._artist = artist;
    this._id = id;
    this._genre = genre;
    this._songList = songList;
  }

  AlbumDetail.fromJson(Map<String, dynamic> json) {
    _url = json['images'][0]["url"];
    _name = json['name'] as String?;
    _artist = json['artists'][0]['name'];
    _id = json['id'];
    _genre = json['genres'].length != 0 ? json['genres'][0] : "";

    dynamic jsonData = json['tracks']['items'];
    List<Map<String, dynamic>> jsonList =
        List<Map<String, dynamic>>.from(jsonData);
    _songList = Song().fromJsonList(jsonList);
  }

  String? get url => _url;
  set url(String? url) => _url = url;

  String? get name => _name;
  set name(String? name) => _name = name;

  String? get artist => _artist;
  set artist(String? artist) => _artist = artist;

  String? get id => _id;
  set id(String? id) => _id = id;

  String? get genre => _genre;
  set genre(String? genre) => _genre = genre;

  List<Song>? get songList => _songList;
  set songList(List<Song>? songList) => _songList = songList;
}

class Song {
  String? _url;
  String? _name;
  String? _artist;
  String? _id;
  int? _duration;

  Song({
    String? url,
    String? name,
    String? artist,
    String? id,
    int? duration,
  }) {
    this._url = url;
    this._name = name;
    this._artist = artist;
    this._id = id;
    this._duration = duration;
  }

  Song.fromJson(Map<String, dynamic> json) {
    // _url = json['images'][1]["url"];
    url = "";
    _name = json['name'] as String?;
    _artist = json['artists'][0]['name'];
    _id = json['id'];
    _duration = json['duration_ms'];
  }

  List<Song> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => Song.fromJson(json)).toList();
  }

  String? get url => _url;
  set url(String? url) => _url = url;

  String? get name => _name;
  set name(String? name) => _name = name;

  String? get artist => _artist;
  set artist(String? artist) => _artist = artist;

  String? get id => _id;
  set id(String? id) => _id = id;

  int? get duration => _duration;
  set duration(int? duration) => _duration = duration;
}
