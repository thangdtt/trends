import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/utils/pref_utils.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitial();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is LoadTheme) {
      yield ThemeLoading();
      bool isDarkMode = await PrefUtils.getIsDarkModePref();
      bool isFastReadMode = await PrefUtils.getIsFastReadModePref();
      double pageFontSizeFactor = await PrefUtils.getPageFontSizeFactorPref();
      int pageBackgroundColor = await PrefUtils.getPageBackgroundColorPref();
      var backColorEnum = contentBackgroundColor.values[pageBackgroundColor];
      int textColor = await PrefUtils.getTextColorPref();
      var textColorEnum = contentTextColor.values[textColor];

      yield ThemeLoaded(
        pageFontSizeFactor: pageFontSizeFactor,
        isDarkMode: isDarkMode,
        themeData: isDarkMode
            ? appThemeData[AppTheme.Dark]
            : appThemeData[AppTheme.Light],
        isFastReadMode: isFastReadMode,
        pageBackgroundColor: contentBackgroundColorData[backColorEnum],
        textColor: contentTextColorData[textColorEnum],
      );
    } else if (event is ThemeChanged) {
      bool isDarkMode = await PrefUtils.getIsDarkModePref();
      bool isFastReadMode = await PrefUtils.getIsFastReadModePref();
      double pageFontSizeFactor = await PrefUtils.getPageFontSizeFactorPref();
      int pageBackgroundColor = await PrefUtils.getPageBackgroundColorPref();
      var backColorEnum = contentBackgroundColor.values[pageBackgroundColor];
      int textColor = await PrefUtils.getTextColorPref();
      var textColorEnum = contentTextColor.values[textColor];

      yield ThemeLoaded(
        isDarkMode: isDarkMode,
        themeData: isDarkMode
            ? appThemeData[AppTheme.Dark]
            : appThemeData[AppTheme.Light],
        isFastReadMode: isFastReadMode,
        pageFontSizeFactor: pageFontSizeFactor,
        pageBackgroundColor: contentBackgroundColorData[backColorEnum],
        textColor: contentTextColorData[textColorEnum],
      );
    }
  }
}
