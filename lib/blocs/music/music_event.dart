part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();
}

class FetchMusics extends MusicEvent {
  const FetchMusics();

  @override
  List<Object> get props => [];
}

class RefreshMusics extends MusicEvent {


  const RefreshMusics();

  @override
  List<Object> get props => [];
}
