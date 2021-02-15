import 'package:cryptoboard/data/models/news/news_model.dart';
import 'package:http/http.dart' as http;

class NewsDataProvider {
  final httpClient = http.Client();

  Future<News> fetchTrendingNews() async {
    final newsUrl =
        'https://min-api.cryptocompare.com/data/v2/news/?lang=EN&sortOrder=popular&excludeCategories=Sponsored&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}';
    final newsResponse = await httpClient.get(newsUrl);
    if (newsResponse.statusCode == 200) {
      final newsJson = newsResponse.body;
      return newsFromJson(str: newsJson);
    } else {
      throw Exception('failed to fetch news');
    }
  }

  Future<News> fetchEthereumNews() async {
    final newsUrl =
        'https://min-api.cryptocompare.com/data/v2/news/?lang=EN&categories=ETH&sortOrder=popular&excludeCategories=Sponsored&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}';
    final newsResponse = await httpClient.get(newsUrl);
    if (newsResponse.statusCode == 200) {
      final newsJson = newsResponse.body;
      return newsFromJson(str: newsJson);
    } else {
      throw Exception('failed to fetch news');
    }
  }

  Future<News> fetchRippleNews() async {
    final newsUrl =
        'https://min-api.cryptocompare.com/data/v2/news/?lang=EN&categories=XRP&sortOrder=popular&excludeCategories=Sponsored&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}';
    final newsResponse = await httpClient.get(newsUrl);
    if (newsResponse.statusCode == 200) {
      final newsJson = newsResponse.body;
      return newsFromJson(str: newsJson);
    } else {
      throw Exception('failed to fetch news');
    }
  }

  Future<News> fetchBitcoinNews() async {
    final newsUrl =
        'https://min-api.cryptocompare.com/data/v2/news/?lang=EN&categories=BTC&sortOrder=popular&excludeCategories=Sponsored&api_key={a6564ba9e8eed309100d3fa4b69b3341fc2463b81a7f183d7d64fc20fb9a86b5}';
    final newsResponse = await httpClient.get(newsUrl);
    if (newsResponse.statusCode == 200) {
      final newsJson = newsResponse.body;
      return newsFromJson(str: newsJson);
    } else {
      throw Exception('failed to fetch news');
    }
  }
}
