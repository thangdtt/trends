import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'savedmusicbloc_event.dart';
part 'savedmusicbloc_state.dart';

class SavedmusicblocBloc extends Bloc<SavedmusicblocEvent, SavedmusicblocState> {
  @override
  SavedmusicblocState get initialState => SavedmusicblocInitial();

  @override
  Stream<SavedmusicblocState> mapEventToState(
    SavedmusicblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
