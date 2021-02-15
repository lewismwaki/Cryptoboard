import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'text_field_event.dart';
part 'text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(TextFieldInitial());

  @override
  Stream<TextFieldState> mapEventToState(TextFieldEvent event) async* {
    if (event is LoadTextFieldInitial) {
      yield (TextFieldInitial());
    }
    if (event is TapTextFieldOne) {
      yield (TextFieldOneTapped());
    }
    if (event is TapTextFieldTwo) {
      yield (TextFieldTwoTapped());
    }
  }
}
