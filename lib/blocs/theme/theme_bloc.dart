import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/utils/pref_utils.dart';
import 'package:trends/utils/utils_class.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitial();
  Map<categoryEnum, bool> tabFilter;

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
      tabFilter = {
        categoryEnum.TinNong: false,
        categoryEnum.TinMoi: false,
        categoryEnum.ThoiSu: false,
        categoryEnum.TheGioi: false,
        categoryEnum.KinhDoanh: false,
        categoryEnum.GiaiTri: false,
        categoryEnum.TheThao: false,
        categoryEnum.PhapLuat: false,
        categoryEnum.GiaoDuc: false,
        categoryEnum.SucKhoe: false,
        categoryEnum.DoiSong: false,
        categoryEnum.DuLich: false,
        categoryEnum.KhoaHoc: false,
        categoryEnum.SoHoa: false,
        categoryEnum.Xe: false,
      };
      List<String> filterList = await PrefUtils.getFilterPref().then((value) {
        tabFilter = loadFilterPrefToMap(value, tabFilter);
        return value;
      });

      yield ThemeLoaded(
        pageFontSizeFactor: pageFontSizeFactor,
        isDarkMode: isDarkMode,
        themeData: isDarkMode
            ? appThemeData[AppTheme.Dark]
            : appThemeData[AppTheme.Light],
        isFastReadMode: isFastReadMode,
        pageBackgroundColor: contentBackgroundColorData[backColorEnum],
        textColor: contentTextColorData[textColorEnum],
        filterList: filterList,
        tabFilter: tabFilter,
      );
    } else if (event is ThemeChanged) {
      bool isDarkMode = await PrefUtils.getIsDarkModePref();
      bool isFastReadMode = await PrefUtils.getIsFastReadModePref();
      double pageFontSizeFactor = await PrefUtils.getPageFontSizeFactorPref();
      int pageBackgroundColor = await PrefUtils.getPageBackgroundColorPref();
      var backColorEnum = contentBackgroundColor.values[pageBackgroundColor];
      int textColor = await PrefUtils.getTextColorPref();
      var textColorEnum = contentTextColor.values[textColor];
      List<String> filterList = await PrefUtils.getFilterPref();

      yield ThemeLoaded(
          isDarkMode: isDarkMode,
          themeData: isDarkMode
              ? appThemeData[AppTheme.Dark]
              : appThemeData[AppTheme.Light],
          isFastReadMode: isFastReadMode,
          pageFontSizeFactor: pageFontSizeFactor,
          pageBackgroundColor: contentBackgroundColorData[backColorEnum],
          textColor: contentTextColorData[textColorEnum],
          filterList: filterList,
          tabFilter: tabFilter);
    }
  }
}
