part of 'calculator_bloc.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();
}

class CalculatorInitial extends CalculatorState {
  @override
  List<Object> get props => [];
}

class AddedNumberSuccess extends CalculatorState {
  final int addedNum;

  AddedNumberSuccess({this.addedNum});
  @override
  List<Object> get props => [addedNum];
}
