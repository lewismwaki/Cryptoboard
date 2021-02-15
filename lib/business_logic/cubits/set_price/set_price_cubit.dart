import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'file:///D:/LEWY/Dev/Projects/ROUGH/Flutter/cryptoboard/lib/data/models/asset/asset_model.dart';

part 'set_price_state.dart';

class SetPriceCubit extends Cubit<SetPriceState> {
  SetPriceCubit() : super(SetPriceInitial());

  Future<void> LoadPriceInitial() async {
    emit(SetPriceInitial());
  }

  Future<void> setPriceOne() async {
    emit(SetPriceOneSuccess());
  }

  Future<void> setPriceTwo() async {
    emit(SetPriceTwoSuccess());
  }

  Future<void> LoadAllPrices() async {
    emit(AllPricesLoadSuccess());
  }
}
