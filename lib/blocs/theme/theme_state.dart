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
  final double pageFontSizeFactor;
  final Color pageBackgroundColor;
  final Color titleColor;
  final Color textColor;

  ThemeLoaded({
    this.themeData,
    this.isDarkMode,
    this.isFastReadMode,
    this.pageFontSizeFactor,
    this.pageBackgroundColor,
    this.textColor,
    this.titleColor,
  });

  @override
  List<Object> get props => [
        themeData,
        isDarkMode,
        isFastReadMode,
        pageFontSizeFactor,
        pageBackgroundColor,
        titleColor,
        textColor,
      ];
}
