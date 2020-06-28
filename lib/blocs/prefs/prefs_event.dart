part of 'prefs_bloc.dart';

abstract class PrefsEvent extends Equatable {
  const PrefsEvent();
}

class GetPrefs extends PrefsEvent{

  @override
  List<Object> get props => [];

}