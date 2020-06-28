import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitial();

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is LoadTheme)
    {
      yield ThemeLoading();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isDarkMode;
      if (prefs.getBool('isDarkMode') != null)
        isDarkMode = prefs.getBool('isDarkMode');
      else
        isDarkMode = false;

      yield ThemeLoaded(
          isDarkMode: isDarkMode,
          themeData: isDarkMode
              ? appThemeData[AppTheme.Dark]
              : appThemeData[AppTheme.Light]);
    
    }
    else if (event is ThemeChanged) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isDarkMode;
      if (prefs.getBool('isDarkMode') != null)
        isDarkMode = prefs.getBool('isDarkMode');
      else
        isDarkMode = false;

      yield ThemeLoaded(
          isDarkMode: isDarkMode,
          themeData: isDarkMode
              ? appThemeData[AppTheme.Dark]
              : appThemeData[AppTheme.Light]);
    }
  }
}
