import 'package:cryptoboard/data/models/asset/asset_model.dart';
import 'package:http/http.dart' as http;

class AssetDataProvider {
  final httpClient = http.Client();

  Future<AssetsClass> fetchAssets() async {
    final assetsUrl = 'https://api.coincap.io/v2/assets';
    final assetsResponse = await httpClient.get(assetsUrl);
    if (assetsResponse.statusCode == 200) {
      final assetJson = assetsResponse.body;
      return assetFromJson(str: assetJson);
    } else {
      throw Exception('failed to fetch assets by rank');
    }
  }
}
