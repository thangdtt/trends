part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;
  final bool isFastReadMode;

  ThemeChanged({this.isDarkMode, this.isFastReadMode});

  @override
  List<Object> get props => [isDarkMode, isFastReadMode];
}

class LoadTheme extends ThemeEvent {
  @override
  List<Object> get props => [];
}
