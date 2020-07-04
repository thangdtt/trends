import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trends/data/models/music.dart';

String musicUrl = ('https://server294.azurewebsites.net/music/');
//String musicUrl = ('http://127.0.0.1:5000/music/');

class MusicRepository {
  String category;
  MusicRepository(String category){
    this.category = category;
  }

  Future<List<Music>> getMusics() async {
    String url = musicUrl + '$category';

    http.Response response;
    try {
      response = await http.get(url);
    } on SocketException catch (_) {
      return [];
    }

    List<Music> musics = <Music>[];


    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        final Music music = Music.fromJson(decoded[i]);
        musics.add(music);
      }

      return musics;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
