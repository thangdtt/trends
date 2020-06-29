part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;
  final bool isFastReadMode;
  final double pageFontSizeFactor;
  final Color pageBackgroundColor;
  final Color titleColor;
  final Color textColor;

  ThemeChanged({
    this.isDarkMode,
    this.isFastReadMode,
    this.pageFontSizeFactor,
    this.pageBackgroundColor,
    this.textColor,
    this.titleColor,
  });

  @override
  List<Object> get props => [
        isDarkMode,
        isFastReadMode,
        pageFontSizeFactor,
        pageBackgroundColor,
        textColor,
        titleColor
      ];
}

class LoadTheme extends ThemeEvent {
  @override
  List<Object> get props => [];
}
