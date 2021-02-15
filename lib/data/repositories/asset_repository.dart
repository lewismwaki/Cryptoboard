import 'package:cryptoboard/data/data_providers/asset_data_provider.dart';
import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:flutter/material.dart';

class AssetRepository {
  final AssetDataProvider assetDataProvider;

  AssetRepository({@required this.assetDataProvider}) : assert(assetDataProvider != null);

  Future<AssetsClass> getAssets() async {
    return assetDataProvider.fetchAssets();
  }
}
