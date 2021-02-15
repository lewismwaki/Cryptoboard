import 'package:cryptoboard/data/data_providers/all_coins_data_provider.dart';
import 'package:cryptoboard/data/models/all_coins/all_coins_model.dart';
import 'package:flutter/cupertino.dart';

class AllCoinsRepository {
  final AllCoinsDataProvider allCoinsDataProvider;
  AllCoinsRepository({@required this.allCoinsDataProvider}) : assert(allCoinsDataProvider != null);

  Future<AllCoinsModel> getCoinData() async {
    return allCoinsDataProvider.fetchCoinData();
  }
}
