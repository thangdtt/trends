part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();
}

class MusicInitial extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoading extends MusicState {
  const MusicLoading();
  @override
  List<Object> get props => [];
}

class MusicLoaded extends MusicState {
  final List<Music> musics;
  final List<Audio> audios;
  const MusicLoaded(this.musics,this.audios);

  @override
  List<Object> get props => [musics,audios];
}

class MusicError extends MusicState {
  final String message;
  const MusicError(this.message);
  @override
  List<Object> get props => [message];
}

class MusicRefreshing extends MusicState {
  const MusicRefreshing();

  @override
  List<Object> get props => [];
}

class MusicRefreshed extends MusicState {
  final List<Music> musics;
  final List<Audio> audios;
  const MusicRefreshed(this.musics, this.audios);

  @override
  List<Object> get props => [musics];
}

