part of 'prefs_bloc.dart';

abstract class PrefsState extends Equatable {
  const PrefsState();
}

class PrefsInitial extends PrefsState {
  @override
  List<Object> get props => [];
}

class PrefsLoading extends PrefsState {
  @override
  List<Object> get props => [];
}

class PrefsLoaded extends PrefsState {
  final bool isDarkMode;
  PrefsLoaded({this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}
