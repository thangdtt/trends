part of 'saved_music_bloc.dart';

abstract class SavedMusicState extends Equatable {
  const SavedMusicState();
}

class SavedMusicInitial extends SavedMusicState {
  @override
  List<Object> get props => [];
}

class SavedMusicLoading extends SavedMusicState {
  @override
  List<Object> get props => [];
}

class SavedMusicLoaded extends SavedMusicState {
  final List<Music> musics;

  SavedMusicLoaded(this.musics);

  @override
  List<Object> get props => [];
}

class SavedMusicError extends SavedMusicState {
  final String message;

  SavedMusicError(this.message);
  @override
  List<Object> get props => [message];
}
