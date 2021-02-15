import 'package:cryptoboard/data/data_providers/news_data_provider.dart';
import 'package:cryptoboard/data/models/news/news_model.dart';
import 'package:flutter/material.dart';

class NewsRepository {
  final NewsDataProvider newsDataProvider;

  NewsRepository({@required this.newsDataProvider}) : assert(newsDataProvider != null);

  Future<News> getTrendingNews() async {
    return newsDataProvider.fetchTrendingNews();
  }

  Future<News> getBitcoinNews() async {
    return newsDataProvider.fetchBitcoinNews();
  }

  Future<News> getEthereumNews() async {
    return newsDataProvider.fetchEthereumNews();
  }

  Future<News> getRippleNews() async {
    return newsDataProvider.fetchRippleNews();
  }
}
