part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoading extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeLoaded extends ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;
  final bool isFastReadMode;
  
  ThemeLoaded({this.themeData, this.isDarkMode, this.isFastReadMode});

  @override
  List<Object> get props => [themeData, isDarkMode, isFastReadMode];
}