import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  @override
  TemplateState get initialState => TemplateInitial();

  @override
  Stream<TemplateState> mapEventToState(
    TemplateEvent event,
  ) async* {


    
  }
}
