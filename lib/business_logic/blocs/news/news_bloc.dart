import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/news/news_model.dart';
import 'package:cryptoboard/data/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository})
      : assert(newsRepository != null),
        super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsRequested) {
      yield NewsLoadInProgress();
      try {
        final News trendingNews = await newsRepository.getTrendingNews();
        final News bitcoinNews = await newsRepository.getBitcoinNews();
        final News ethereumNews = await newsRepository.getEthereumNews();
        final News rippleNews = await newsRepository.getRippleNews();
        yield NewsLoadSuccess(trendingNews: trendingNews, bitcoinNews: bitcoinNews, ethereumNews: ethereumNews, rippleNews: rippleNews);
      } catch (_) {
        yield NewsLoadFailure();
      }
    }

    if (event is NewsLoadInitial) {
      final News bitcoinNews = await newsRepository.getBitcoinNews();

      yield NewsInitial(
        bitcoinNews: bitcoinNews,
      );
    }
  }
}
