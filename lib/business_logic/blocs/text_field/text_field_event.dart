part of 'text_field_bloc.dart';

abstract class TextFieldEvent extends Equatable {
  const TextFieldEvent();
}

class LoadTextFieldInitial extends TextFieldEvent {
  @override
  List<Object> get props => [];
}

class TapTextFieldOne extends TextFieldEvent {
  @override
  List<Object> get props => [];
}

class TapTextFieldTwo extends TextFieldEvent {
  @override
  List<Object> get props => [];
}
