import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trends/ui/global/theme/app_theme.dart';
import 'package:trends/utils/pref_utils.dart';
import 'package:trends/utils/utils_class.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitial();
  Map<CategoryEnum, bool> tabFilter;

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
        CategoryEnum.TinNong: true,
        CategoryEnum.TinMoi: true,
        CategoryEnum.ThoiSu: true,
        CategoryEnum.TheGioi: true,
        CategoryEnum.KinhDoanh: true,
        CategoryEnum.GiaiTri: true,
        CategoryEnum.TheThao: true,
        CategoryEnum.PhapLuat: true,
        CategoryEnum.NhipSongTre: true,
        CategoryEnum.VanHoa: true,
        CategoryEnum.GiaoDuc: true,
        CategoryEnum.SucKhoe: true,
        CategoryEnum.DoiSong: true,
        CategoryEnum.DuLich: true,
        CategoryEnum.KhoaHoc: true,
        CategoryEnum.SoHoa: true,
        CategoryEnum.Xe: true,
        CategoryEnum.GiaThat: true,
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
