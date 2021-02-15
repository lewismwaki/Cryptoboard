import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:cryptoboard/data/models/news/news_model.dart';
import 'package:cryptoboard/data/repositories/asset_repository.dart';
import 'package:cryptoboard/data/repositories/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_content_state.dart';

class HomeContentCubit extends Cubit<HomeContentState> {
  final AssetRepository assetRepository;
  final NewsRepository newsRepository;
  HomeContentCubit({@required this.newsRepository, @required this.assetRepository})
      : assert(assetRepository != null, newsRepository != null),
        super(HomeContentInitial());

  Future<void> loadHomeContent() async {
    try {
      emit(HomeContentLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      final News trendingNews = await newsRepository.getTrendingNews();
      emit(HomeContentLoadSuccess(assetsClass: assetsClass, trendingNews: trendingNews));
    } catch (_) {
      emit(HomeContentLoadFailure());
    }
  }

  Future<void> loadSearchSuggestions() async {
    try {
      final AssetsClass assetsClass = await assetRepository.getAssets();
      final News trendingNews = await newsRepository.getTrendingNews();
      emit(SearchSuggestions(assetsClass: assetsClass, trendingNews: trendingNews));
    } catch (_) {
      emit(HomeContentLoadFailure());
    }
  }

  Future<void> loadSearchResults() async {
    try {
      final AssetsClass assetsClass = await assetRepository.getAssets();
      final News trendingNews = await newsRepository.getTrendingNews();
      emit(SearchResults(assetsClass: assetsClass, trendingNews: trendingNews));
    } catch (_) {
      emit(HomeContentLoadFailure());
    }
  }
}
