import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/data/moor_database.dart';
import 'package:trends/utils/global_repo.dart';

part 'saved_music_event.dart';
part 'saved_music_state.dart';

class SavedMusicBloc extends Bloc<SavedMusicEvent, SavedMusicState> {
  List<Music> saveMusics = [];
  @override
  SavedMusicState get initialState => SavedMusicInitial();

  @override
  Stream<SavedMusicState> mapEventToState(
    SavedMusicEvent event,
  ) async* {
    if (event is GetAllSaveMusic) {
      yield SavedMusicLoading();
      try {
        List<SavedMusicData> _list = await databaseRepo.getAllSaveMusic();

        if (_list != null) {
          saveMusics = [];
          for (var item in _list) {
            List<String> _qualities = item.qualities.split('~');
            List<String> _qualityLink = item.qualityLink.split('~');
            saveMusics.add(new Music(
              album: item.album,
              composer: item.composer,
              country: item.country,
              image: item.image,
              id: item.id,
              link: item.link,
              name: item.name,
              releaseYear: item.releaseYear,
              singer: item.singer,
              qualities: _qualities,
              qualityLink: _qualityLink,
            ));
          }
        }

        yield SavedMusicLoaded(saveMusics.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedMusicError("get saved music error");
      }
    } else if (event is AddSaveMusic) {
      yield SavedMusicLoading();
      try {
        SavedMusicData saveMusic;
        String _saveQualities = "", _saveQualityLink = "";
        event.music.qualities.forEach((element) {
          _saveQualities += element + '~';
        });
        event.music.qualityLink.forEach((element) {
          _saveQualityLink += element + '~';
        });

        //delete last "~" character
        _saveQualities = _saveQualities.substring(0, _saveQualities.length - 1);
        _saveQualityLink = _saveQualityLink.substring(0, _saveQualityLink.length - 1);
        
        saveMusic = new SavedMusicData(
            id: event.music.id,
            link: event.music.link,
            name: event.music.name,
            singer: event.music.singer,
            album: event.music.album,
            composer: event.music.composer,
            country: event.music.country,
            image: event.music.image,
            releaseYear: event.music.releaseYear,
            qualities: _saveQualities,
            qualityLink: _saveQualityLink,
            addTime: DateTime.now());

        try {
          await databaseRepo.insertSaveMusic(saveMusic);

          List<SavedMusicData> _list = await databaseRepo.getAllSaveMusic();

          if (_list != null) {
            saveMusics = [];
            for (var item in _list) {
              List<String> _qualities = item.qualities.split('~');
              List<String> _qualityLink = item.qualityLink.split('~');
              saveMusics.add(new Music(
                album: item.album,
                composer: item.composer,
                country: item.country,
                image: item.image,
                id: item.id,
                link: item.link,
                name: item.name,
                releaseYear: item.releaseYear,
                singer: item.singer,
                qualities: _qualities,
                qualityLink: _qualityLink,
              ));
            }
          }
        } catch (e) {
          print(e);
          yield SavedMusicLoaded(saveMusics.reversed.toList());
        }

        yield SavedMusicLoaded(saveMusics.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedMusicError("add saved music error");
      }
    } else if (event is DeleteSaveMusic) {
      yield SavedMusicLoading();
      try {
        SavedMusicData saveMusic;
        saveMusic = new SavedMusicData(
            id: event.music.id,
            link: event.music.link,
            name: event.music.name,
            singer: event.music.singer,
            album: event.music.album,
            composer: event.music.composer,
            country: event.music.country,
            image: event.music.image,
            releaseYear: event.music.releaseYear,
            addTime: DateTime.now());

        if (await databaseRepo.deleteSaveMusic(saveMusic) != null) {
          saveMusics.removeWhere((element) => element.id == event.music.id);
        }

        yield SavedMusicLoaded(saveMusics.reversed.toList());
      } catch (e) {
        print(e);
        yield SavedMusicError("delete saved music error");
      }
    }
  }
}
