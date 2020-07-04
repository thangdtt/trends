import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:http/http.dart' as http;
import 'package:trends/data/models/music.dart';

String musicUrl = ('https://server294.azurewebsites.net/music/');
//String musicUrl = ('http://127.0.0.1:5000/music/');

class MusicRepository {
  List<Audio> _audios = [];
  String category;
  MusicRepository(String category){
    this.category = category;
  }
  Future<List<Audio>> getAudios() async {
    return _audios;
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
    _audios.clear();

    if (response.statusCode == 200) {
      List<dynamic> decoded = json.decode(response.body);

      for (int i = 0; i < decoded.length; i++) {
        final Music music = Music.fromJson(decoded[i]);
        musics.add(music);
        _audios.add(Audio(
          music.link,
          metas: Metas(
            id: music.id.toString(),
            title: music.name,
            artist: music.singer,
            album: music.album,
            // image: MetasImage.network("https://www.google.com")
            image: MetasImage.network(music.image),
          ),
        ));
      }

      return musics;
    } else {
      throw Exception('Failed to connect to server');
    }
  }
}
