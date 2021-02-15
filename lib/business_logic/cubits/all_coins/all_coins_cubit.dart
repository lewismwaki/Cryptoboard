import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/all_coins/all_coins_model.dart';
import 'package:cryptoboard/data/repositories/all_coins_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'all_coins_state.dart';

class AllCoinsCubit extends Cubit<AllCoinsState> {
  final AllCoinsRepository allCoinsRepository;
  AllCoinsCubit({@required this.allCoinsRepository}) : super(AllCoinsInitial());

  Future<void> loadCoinData() async {
    try {
      emit(AllCoinsLoadInProgress());
      final AllCoinsModel allCoinsModel = await allCoinsRepository.getCoinData();
      emit(AllCoinsLoadSuccess(allCoinsModel: allCoinsModel));
    } catch (_) {}
  }
}
