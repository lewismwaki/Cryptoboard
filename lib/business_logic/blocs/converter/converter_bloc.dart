import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc() : super(ConverterInitial());

  @override
  Stream<ConverterState> mapEventToState(ConverterEvent event) async* {
    if (event is LoadConverter) {
      yield ConverterLoadSuccess();
    }

    if (event is LoadConverterInitial) {
      yield (ConverterInitial());
    }

    if (event is EnterDecimal) {
      yield AddedDecimalSuccess();
    }
  }
}
