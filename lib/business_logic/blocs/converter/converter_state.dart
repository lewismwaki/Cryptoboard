part of 'converter_bloc.dart';

abstract class ConverterState extends Equatable {
  const ConverterState();
}

class ConverterInitial extends ConverterState {
  @override
  List<Object> get props => [];
}

class ConverterLoadSuccess extends ConverterState {
  @override
  List<Object> get props => [];
}

class AddedDecimalSuccess extends ConverterState {
  final int addedNum;

  AddedDecimalSuccess({this.addedNum});
  @override
  List<Object> get props => [addedNum];
}
