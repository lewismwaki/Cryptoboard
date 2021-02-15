import 'package:bloc/bloc.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:cryptoboard/data/repositories/asset_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  final AssetRepository assetRepository;
  AssetsCubit({@required this.assetRepository})
      : assert(assetRepository != null),
        super(AssetsInitial());

  //rank
  Future<void> sortAssetsByRankAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByRankAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByRankDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByRankDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //market cap
  Future<void> sortAssetsByMarketCapAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByMarketCapAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByMarketCapDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();

      emit(AssetsSortedByMarketCapDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //percentage change
  Future<void> sortAssetsByPercentageChangeAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByPercentageChangeAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByPercentageChangeDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByPercentageChangeDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //name
  Future<void> sortAssetsByNameAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByNameAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByNameDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByNameDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //max supply
  Future<void> sortAssetsByMaxSupplyAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByMaxSupplyAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByMaxSupplyDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByMaxSupplyDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //price
  Future<void> sortAssetsByPriceAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByPriceAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByPriceDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByPriceDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  //volume 24hr
  Future<void> sortAssetsByVolume24hrAscending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByVolume24hrAscending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }

  Future<void> sortAssetsByVolume24hrDescending() async {
    try {
      emit(AssetsLoadInProgress());
      final AssetsClass assetsClass = await assetRepository.getAssets();
      emit(AssetsSortedByVolume24hrDescending(assetsClass: assetsClass));
    } catch (_) {
      emit(AssetsLoadFailure());
    }
  }
}
