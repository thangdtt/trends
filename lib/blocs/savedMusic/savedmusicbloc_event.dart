part of 'savedMusicbloc_bloc.dart';

abstract class SavedMusicEvent extends Equatable {
  const SavedMusicEvent();
}

class GetAllSaveMusic extends SavedMusicEvent {

  @override
  List<Object> get props => [];
}

class AddSaveMusic extends SavedMusicEvent {
  final Music music;
  AddSaveMusic(this.music);

  @override
  List<Object> get props => [music];
}

class DeleteSaveMusic extends SavedMusicEvent {
  final Music music;
  DeleteSaveMusic(this.music);

  @override
  List<Object> get props => [music];
}
