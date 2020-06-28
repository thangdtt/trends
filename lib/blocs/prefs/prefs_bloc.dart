import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prefs_event.dart';
part 'prefs_state.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  @override
  PrefsState get initialState => PrefsInitial();

  @override
  Stream<PrefsState> mapEventToState(
    PrefsEvent event,
  ) async* {
    if(event is GetPrefs)
    {
      yield PrefsLoading();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final isDarkMode = !prefs.getBool('isDarkMode') ? prefs.getBool('isDarkMode'): false;

      yield PrefsLoaded(isDarkMode: isDarkMode);
    }
  }
}
