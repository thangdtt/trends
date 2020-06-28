part of 'template_bloc.dart';

abstract class TemplateState extends Equatable {
  const TemplateState();
}

class TemplateInitial extends TemplateState {
  @override
  List<Object> get props => [];
}
