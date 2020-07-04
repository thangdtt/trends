import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trends/data/models/music.dart';
import 'package:trends/data/music_repository.dart';

part 'music_event.dart';

part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepository _musicRepository;

  String category;

  MusicBloc(String category) {
    this.category = category;
    _musicRepository = new MusicRepository(category);
  }

  @override
  MusicState get initialState => MusicInitial();

  @override
  Stream<Transition<MusicEvent, MusicState>> transformEvents(
    Stream<MusicEvent> events,
    TransitionFunction<MusicEvent, MusicState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MusicState> mapEventToState(
    MusicEvent event,
  ) async* {
    if (event is RefreshMusics) {
      yield MusicRefreshing();
      try {
        final List<Music> listMusics =
            await _musicRepository.getMusics();
        final List<Audio> audios = await _musicRepository.getAudios();
        yield MusicRefreshed(listMusics, audios);
      } on Error {
        //yield MusicError("Error !!!");
        yield state;
      }
    } else {
      yield MusicLoading();
      if (event is FetchMusics) {
        try {
          final listMusics = await _musicRepository.getMusics();
          final List<Audio> audios = await _musicRepository.getAudios();
          yield MusicLoaded(listMusics, audios);
        } on Error {
          yield MusicError("Error !!!");
        }
      }
    }
  }
}
