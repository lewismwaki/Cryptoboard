part of 'converter_bloc.dart';

abstract class ConverterEvent extends Equatable {
  final int num;
  final String decimal;
  const ConverterEvent({this.num, this.decimal});
}

class onChanged extends ConverterEvent {
  final int num;
  final TextEditingController priceTextContoller;

  onChanged({this.priceTextContoller, this.num});
  @override
  List<Object> get props => [num, priceTextContoller];
}

class LoadConverterInitial extends ConverterEvent {




  @override
  List<Object> get props => [];



}

class LoadConverter extends ConverterEvent {
  @override
  List<Object> get props => [];
}

// class TapTextFieldOne extends ConverterEvent {
//   @override
//   List<Object> get props => [];
// }
//
// class TapTextFieldTwo extends ConverterEvent {
//   @override
//   List<Object> get props => [];
// }
//

class EnterDecimal extends ConverterEvent {
  final String decimal;
  final TextEditingController priceTextContoller;

  EnterDecimal({this.priceTextContoller, this.decimal});
  @override
  List<Object> get props => [decimal, priceTextContoller];
}
