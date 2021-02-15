import 'package:cryptoboard/data/models/all_coins/all_coins_model.dart';
import 'package:http/http.dart' as http;

class AllCoinsDataProvider {
  final httpClient = http.Client();

  Future<AllCoinsModel> fetchCoinData() async {
    final allCoinsUrl = 'https://min-api.cryptocompare.com/data/all/coinlist';
    final allCoinsResponse = await httpClient.get(allCoinsUrl);
    if (allCoinsResponse.statusCode == 200) {
      final allCoinsJson = allCoinsResponse.body;
      return allCoinsModelFromJson(allCoinsJson);
    } else {
      print(Exception());
      throw Exception();
    }
  }
}
