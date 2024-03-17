import 'dart:convert';

import 'package:spotify_flutter/model/albumModel.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  static const token = "ADD TOKEN HERE"; //ADD TOKEN HERE
  Future<List<Album>> searchAlbums(
      String keyword, int pageIndex, int pageSize) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.spotify.com/v1/search?q=$keyword&type=album&limit=$pageSize&offset=$pageIndex'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final List<dynamic> albumList = result['albums']['items'];
        List<Album> albums =
            albumList.map((albumMap) => Album.fromJson(albumMap)).toList();

        return albums;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return [];
  }

  Future<AlbumDetail> getAlbum(String id) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/albums/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        final Map<String, dynamic> album = result;
        AlbumDetail albumDetail = AlbumDetail.fromJson(album);

        return albumDetail;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return AlbumDetail();
  }
}
