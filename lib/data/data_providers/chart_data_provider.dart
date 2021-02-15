import 'package:cryptoboard/data/models/chart/chart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ChartDataProvider {
  final httpClient = http.Client();

  Future<ChartModel> fetchChart({
    @required String symbol,
    @required String time,
    @required String limit,
    @required String aggregate,
  }) async {
    final chartsUrl = symbol != 'USDT'
        ? "https://min-api.cryptocompare.com/data/v2/histo${time}?fsym=${symbol}&tsym=USDT&limit=${limit}&aggregate=${aggregate}&e=binance&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}"
        : 'https://min-api.cryptocompare.com/data/v2/histo${time}?fsym=usdt&tsym=USD&limit=${limit}&aggregate=${aggregate}&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}';
    final chartsResponse = await httpClient.get(chartsUrl);
    if (chartsResponse.statusCode == 200) {
      final chartJson = chartsResponse.body;
      print('fetch successfully');
      return chartModelFromJson(str: chartJson);
    } else {
      print('failed to fetch');
      throw Exception('failed to fetch news');
    }
  }
}
