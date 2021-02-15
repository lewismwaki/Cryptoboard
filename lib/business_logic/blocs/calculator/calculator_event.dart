part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();
}

class LoadCalculatorInitial extends CalculatorEvent {
  @override
  List<Object> get props => [];
}

class EnterNumber extends CalculatorEvent {
  final int num;
  final TextEditingController priceTextContoller;

  EnterNumber({this.priceTextContoller, this.num});
  @override
  List<Object> get props => [num, priceTextContoller];
}
