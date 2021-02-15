import 'dart:convert';

import 'package:equatable/equatable.dart';

AllCoinsModel allCoinsModelFromJson(String str) => AllCoinsModel.fromJson(json.decode(str));

String allCoinsModelToJson(AllCoinsModel data) => json.encode(data.toJson());

class AllCoinsModel extends Equatable {
  AllCoinsModel({
    this.response,
    this.message,
    this.data,
    this.baseImageUrl,
    this.baseLinkUrl,
    this.rateLimit,
    this.hasWarning,
    this.type,
  });

  final String response;
  final String message;
  final Map<String, Datum> data;
  final String baseImageUrl;
  final String baseLinkUrl;
  final RateLimit rateLimit;
  final bool hasWarning;
  final int type;

  factory AllCoinsModel.fromJson(Map<String, dynamic> json) => AllCoinsModel(
        response: json["Response"],
        message: json["Message"],
        data: Map.from(json["Data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
        baseImageUrl: json["BaseImageUrl"],
        baseLinkUrl: json["BaseLinkUrl"],
        rateLimit: RateLimit.fromJson(json["RateLimit"]),
        hasWarning: json["HasWarning"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Response": response,
        "Message": message,
        "Data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "BaseImageUrl": baseImageUrl,
        "BaseLinkUrl": baseLinkUrl,
        "RateLimit": rateLimit.toJson(),
        "HasWarning": hasWarning,
        "Type": type,
      };

  @override
  List<Object> get props => [
        response,
        message,
        data,
        baseImageUrl,
        baseLinkUrl,
        rateLimit,
        hasWarning,
        type,
      ];
}

class Datum extends Equatable {
  Datum({
    this.id,
    this.url,
    this.imageUrl,
    this.contentCreatedOn,
    this.name,
    this.symbol,
    this.coinName,
    this.fullName,
    this.description,
    this.assetTokenStatus,
    this.algorithm,
    this.proofType,
    this.sortOrder,
    this.sponsored,
    this.taxonomy,
    this.rating,
    this.isTrading,
    this.totalCoinsMined,
    this.blockNumber,
    this.netHashesPerSecond,
    this.blockReward,
    this.blockTime,
    this.assetLaunchDate,
    this.maxSupply,
    this.mktCapPenalty,
    this.platformType,
    this.builtOn,
    this.smartContractAddress,
    this.decimalPoints,
    this.difficulty,
    this.isUsedInDefi,
  });

  final String id;
  final String url;
  final String imageUrl;
  final int contentCreatedOn;
  final String name;
  final String symbol;
  final String coinName;
  final String fullName;
  final String description;
  final AssetTokenStatus assetTokenStatus;
  final String algorithm;
  final String proofType;
  final String sortOrder;
  final bool sponsored;
  final Taxonomy taxonomy;
  final Rating rating;
  final bool isTrading;
  final double totalCoinsMined;
  final int blockNumber;
  final double netHashesPerSecond;
  final double blockReward;
  final double blockTime;
  final dynamic assetLaunchDate;
  final double maxSupply;
  final double mktCapPenalty;
  final PlatformType platformType;
  final dynamic builtOn;
  final String smartContractAddress;
  final int decimalPoints;
  final double difficulty;
  final int isUsedInDefi;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["Id"],
        url: json["Url"],
        imageUrl: json["ImageUrl"] == null ? null : json["ImageUrl"],
        contentCreatedOn: json["ContentCreatedOn"],
        name: json["Name"],
        symbol: json["Symbol"],
        coinName: json["CoinName"],
        fullName: json["FullName"],
        description: json["Description"],
        assetTokenStatus: assetTokenStatusValues.map[json["AssetTokenStatus"]],
        algorithm: json["Algorithm"],
        proofType: json["ProofType"],
        sortOrder: json["SortOrder"],
        sponsored: json["Sponsored"],
        taxonomy: Taxonomy.fromJson(json["Taxonomy"]),
        rating: Rating.fromJson(json["Rating"]),
        isTrading: json["IsTrading"],
        totalCoinsMined: json["TotalCoinsMined"] == null ? null : json["TotalCoinsMined"].toDouble(),
        blockNumber: json["BlockNumber"] == null ? null : json["BlockNumber"],
        netHashesPerSecond: json["NetHashesPerSecond"] == null ? null : json["NetHashesPerSecond"].toDouble(),
        blockReward: json["BlockReward"] == null ? null : json["BlockReward"].toDouble(),
        blockTime: json["BlockTime"] == null ? null : json["BlockTime"].toDouble(),
        assetLaunchDate: json["AssetLaunchDate"],
        maxSupply: json["MaxSupply"] == null ? null : json["MaxSupply"].toDouble(),
        mktCapPenalty: json["MktCapPenalty"] == null ? null : json["MktCapPenalty"].toDouble(),
        platformType: json["PlatformType"] == null ? null : platformTypeValues.map[json["PlatformType"]],
        builtOn: json["BuiltOn"],
        smartContractAddress: json["SmartContractAddress"] == null ? null : json["SmartContractAddress"],
        decimalPoints: json["DecimalPoints"] == null ? null : json["DecimalPoints"],
        difficulty: json["Difficulty"] == null ? null : json["Difficulty"].toDouble(),
        isUsedInDefi: json["IsUsedInDefi"] == null ? null : json["IsUsedInDefi"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Url": url,
        "ImageUrl": imageUrl == null ? null : imageUrl,
        "ContentCreatedOn": contentCreatedOn,
        "Name": name,
        "Symbol": symbol,
        "CoinName": coinName,
        "FullName": fullName,
        "Description": description,
        "AssetTokenStatus": assetTokenStatusValues.reverse[assetTokenStatus],
        "Algorithm": algorithm,
        "ProofType": proofType,
        "SortOrder": sortOrder,
        "Sponsored": sponsored,
        "Taxonomy": taxonomy.toJson(),
        "Rating": rating.toJson(),
        "IsTrading": isTrading,
        "TotalCoinsMined": totalCoinsMined == null ? null : totalCoinsMined,
        "BlockNumber": blockNumber == null ? null : blockNumber,
        "NetHashesPerSecond": netHashesPerSecond == null ? null : netHashesPerSecond,
        "BlockReward": blockReward == null ? null : blockReward,
        "BlockTime": blockTime == null ? null : blockTime,
        "AssetLaunchDate": assetLaunchDate,
        "MaxSupply": maxSupply == null ? null : maxSupply,
        "MktCapPenalty": mktCapPenalty == null ? null : mktCapPenalty,
        "PlatformType": platformType == null ? null : platformTypeValues.reverse[platformType],
        "BuiltOn": builtOn,
        "SmartContractAddress": smartContractAddress == null ? null : smartContractAddress,
        "DecimalPoints": decimalPoints == null ? null : decimalPoints,
        "Difficulty": difficulty == null ? null : difficulty,
        "IsUsedInDefi": isUsedInDefi == null ? null : isUsedInDefi,
      };

  @override
  List<Object> get props => [
        id,
        url,
        imageUrl,
        contentCreatedOn,
        name,
        symbol,
        coinName,
        fullName,
        description,
        assetTokenStatus,
        algorithm,
        proofType,
        sortOrder,
        sponsored,
        taxonomy,
        rating,
        isTrading,
        totalCoinsMined,
        blockNumber,
        netHashesPerSecond,
        blockReward,
        blockTime,
        assetLaunchDate,
        maxSupply,
        mktCapPenalty,
        platformType,
        builtOn,
        smartContractAddress,
        decimalPoints,
        difficulty,
        isUsedInDefi,
      ];
}

enum AssetLaunchDateEnum {
  THE_00000000,
  THE_21122017,
  THE_04042019,
  THE_20190710,
  THE_20190729,
  THE_20200203,
  THE_20200403,
  THE_20200908,
  THE_20181113,
  THE_20200822,
  THE_20160524,
  THE_20180516,
  THE_23072016,
  ETH
}

final assetLaunchDateEnumValues = EnumValues({
  "ETH": AssetLaunchDateEnum.ETH,
  "0000-00-00": AssetLaunchDateEnum.THE_00000000,
  "04/04/2019": AssetLaunchDateEnum.THE_04042019,
  "2016/05/24": AssetLaunchDateEnum.THE_20160524,
  "2018/05/16": AssetLaunchDateEnum.THE_20180516,
  "2018-11-13 ": AssetLaunchDateEnum.THE_20181113,
  " 2019-07-10": AssetLaunchDateEnum.THE_20190710,
  " 2019-07-29": AssetLaunchDateEnum.THE_20190729,
  " 2020-02-03": AssetLaunchDateEnum.THE_20200203,
  " 2020-04-03": AssetLaunchDateEnum.THE_20200403,
  " 2020-08-22": AssetLaunchDateEnum.THE_20200822,
  " 2020-09-08": AssetLaunchDateEnum.THE_20200908,
  "21/12/2017": AssetLaunchDateEnum.THE_21122017,
  "23/07/2016": AssetLaunchDateEnum.THE_23072016
});

enum AssetTokenStatus { N_A, FINISHED, ONGOING, UPCOMING }

final assetTokenStatusValues = EnumValues(
    {"Finished": AssetTokenStatus.FINISHED, "N/A": AssetTokenStatus.N_A, "Ongoing": AssetTokenStatus.ONGOING, "Upcoming": AssetTokenStatus.UPCOMING});

enum BuiltOnEnum {
  ETH,
  OMNI,
  WAVES,
  NEO,
  MAINNET_BNB,
  XLM,
  EOS,
  GO,
  VET,
  MAINNET_ETH,
  NAS,
  ETH_BNB,
  TRX,
  IOST,
  BNB,
  WAVES_ETH,
  LUNIVERSE,
  QTUM,
  RSK_NETWORK,
  KAVA,
  ETH_BNB_MAINNET,
  ETH_WAN,
  ETH_BTC_EOS_TRX_ALGO_SLP_OMG,
  BUILT_ON_MAINNET_BNB,
  ONT,
  STRAX,
  TRX_ETH,
  XMR,
  MAINNET_NEO_ETH
}

final builtOnEnumValues = EnumValues({
  "BNB": BuiltOnEnum.BNB,
  "mainnet,BNB": BuiltOnEnum.BUILT_ON_MAINNET_BNB,
  "EOS": BuiltOnEnum.EOS,
  "ETH": BuiltOnEnum.ETH,
  "ETH,BNB": BuiltOnEnum.ETH_BNB,
  "ETH,BNB,mainnet": BuiltOnEnum.ETH_BNB_MAINNET,
  "ETH,BTC,EOS,TRX,ALGO,SLP,OMG": BuiltOnEnum.ETH_BTC_EOS_TRX_ALGO_SLP_OMG,
  "ETH,WAN": BuiltOnEnum.ETH_WAN,
  "GO": BuiltOnEnum.GO,
  "IOST": BuiltOnEnum.IOST,
  "KAVA": BuiltOnEnum.KAVA,
  "luniverse": BuiltOnEnum.LUNIVERSE,
  "Mainnet,BNB": BuiltOnEnum.MAINNET_BNB,
  "mainnet,ETH": BuiltOnEnum.MAINNET_ETH,
  "Mainnet,NEO,ETH": BuiltOnEnum.MAINNET_NEO_ETH,
  "NAS": BuiltOnEnum.NAS,
  "NEO": BuiltOnEnum.NEO,
  "OMNI": BuiltOnEnum.OMNI,
  "ONT": BuiltOnEnum.ONT,
  "QTUM": BuiltOnEnum.QTUM,
  "RSK Network": BuiltOnEnum.RSK_NETWORK,
  "STRAX": BuiltOnEnum.STRAX,
  "TRX": BuiltOnEnum.TRX,
  "TRX,ETH": BuiltOnEnum.TRX_ETH,
  "VET": BuiltOnEnum.VET,
  "WAVES": BuiltOnEnum.WAVES,
  "WAVES,ETH": BuiltOnEnum.WAVES_ETH,
  "XLM": BuiltOnEnum.XLM,
  "XMR": BuiltOnEnum.XMR
});

enum PlatformType { TOKEN, BLOCKCHAIN, DERIVATIVE }

final platformTypeValues = EnumValues({"blockchain": PlatformType.BLOCKCHAIN, "derivative": PlatformType.DERIVATIVE, "token": PlatformType.TOKEN});

class Rating extends Equatable {
  Rating({
    this.weiss,
  });

  final Weiss weiss;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        weiss: Weiss.fromJson(json["Weiss"]),
      );

  Map<String, dynamic> toJson() => {
        "Weiss": weiss.toJson(),
      };

  @override
  List<Object> get props => [
        weiss,
      ];
}

class Weiss extends Equatable {
  Weiss({
    this.rating,
    this.technologyAdoptionRating,
    this.marketPerformanceRating,
  });

  final MarketPerformanceRatingEnum rating;
  final MarketPerformanceRatingEnum technologyAdoptionRating;
  final MarketPerformanceRatingEnum marketPerformanceRating;

  factory Weiss.fromJson(Map<String, dynamic> json) => Weiss(
        rating: marketPerformanceRatingEnumValues.map[json["Rating"]],
        technologyAdoptionRating: marketPerformanceRatingEnumValues.map[json["TechnologyAdoptionRating"]],
        marketPerformanceRating: marketPerformanceRatingEnumValues.map[json["MarketPerformanceRating"]],
      );

  Map<String, dynamic> toJson() => {
        "Rating": marketPerformanceRatingEnumValues.reverse[rating],
        "TechnologyAdoptionRating": marketPerformanceRatingEnumValues.reverse[technologyAdoptionRating],
        "MarketPerformanceRating": marketPerformanceRatingEnumValues.reverse[marketPerformanceRating],
      };

  @override
  List<Object> get props => [
        rating,
        technologyAdoptionRating,
        marketPerformanceRating,
      ];
}

enum MarketPerformanceRatingEnum { EMPTY, E, D, RATING_E, PURPLE_E, RATING_D, PURPLE_D, C, RATING_C, A, B, RATING_B, PURPLE_C, PURPLE_B, RATING_A }

final marketPerformanceRatingEnumValues = EnumValues({
  "A-": MarketPerformanceRatingEnum.A,
  "B-": MarketPerformanceRatingEnum.B,
  "C": MarketPerformanceRatingEnum.C,
  "D-": MarketPerformanceRatingEnum.D,
  "E+": MarketPerformanceRatingEnum.E,
  "": MarketPerformanceRatingEnum.EMPTY,
  "B+": MarketPerformanceRatingEnum.PURPLE_B,
  "C+": MarketPerformanceRatingEnum.PURPLE_C,
  "D": MarketPerformanceRatingEnum.PURPLE_D,
  "E-": MarketPerformanceRatingEnum.PURPLE_E,
  "A": MarketPerformanceRatingEnum.RATING_A,
  "B": MarketPerformanceRatingEnum.RATING_B,
  "C-": MarketPerformanceRatingEnum.RATING_C,
  "D+": MarketPerformanceRatingEnum.RATING_D,
  "E": MarketPerformanceRatingEnum.RATING_E
});

class Taxonomy extends Equatable {
  Taxonomy({
    this.access,
    this.fca,
    this.finma,
    this.industry,
    this.collateralizedAsset,
    this.collateralizedAssetType,
    this.collateralType,
    this.collateralInfo,
  });

  final Access access;
  final Fca fca;
  final Finma finma;
  final Industry industry;
  final CollateralizedAsset collateralizedAsset;
  final CollateralizedAssetType collateralizedAssetType;
  final CollateralType collateralType;
  final String collateralInfo;

  factory Taxonomy.fromJson(Map<String, dynamic> json) => Taxonomy(
        access: accessValues.map[json["Access"]],
        fca: fcaValues.map[json["FCA"]],
        finma: finmaValues.map[json["FINMA"]],
        industry: industryValues.map[json["Industry"]],
        collateralizedAsset: collateralizedAssetValues.map[json["CollateralizedAsset"]],
        collateralizedAssetType: collateralizedAssetTypeValues.map[json["CollateralizedAssetType"]],
        collateralType: collateralTypeValues.map[json["CollateralType"]],
        collateralInfo: json["CollateralInfo"],
      );

  Map<String, dynamic> toJson() => {
        "Access": accessValues.reverse[access],
        "FCA": fcaValues.reverse[fca],
        "FINMA": finmaValues.reverse[finma],
        "Industry": industryValues.reverse[industry],
        "CollateralizedAsset": collateralizedAssetValues.reverse[collateralizedAsset],
        "CollateralizedAssetType": collateralizedAssetTypeValues.reverse[collateralizedAssetType],
        "CollateralType": collateralTypeValues.reverse[collateralType],
        "CollateralInfo": collateralInfo,
      };

  @override
  List<Object> get props => [
        access,
        fca,
        collateralInfo,
        collateralizedAsset,
        collateralizedAssetType,
        collateralType,
        industry,
        finma,
      ];
}

enum Access { EMPTY, PERMISSIONLESS, PERMISSIONED }

final accessValues = EnumValues({"": Access.EMPTY, "Permissioned": Access.PERMISSIONED, "Permissionless": Access.PERMISSIONLESS});

enum CollateralType { EMPTY, EQUITY, COMMODITY, CURRENCY, BOND }

final collateralTypeValues = EnumValues({
  "Bond": CollateralType.BOND,
  "Commodity": CollateralType.COMMODITY,
  "Currency": CollateralType.CURRENCY,
  "": CollateralType.EMPTY,
  "Equity": CollateralType.EQUITY
});

enum CollateralizedAsset { EMPTY, NO, YES, PARTIALLY }

final collateralizedAssetValues = EnumValues(
    {"": CollateralizedAsset.EMPTY, "No": CollateralizedAsset.NO, "Partially": CollateralizedAsset.PARTIALLY, "Yes": CollateralizedAsset.YES});

enum CollateralizedAssetType { EMPTY, SECURITY_TOKEN, STABLECOIN }

final collateralizedAssetTypeValues = EnumValues(
    {"": CollateralizedAssetType.EMPTY, "Security Token": CollateralizedAssetType.SECURITY_TOKEN, "Stablecoin": CollateralizedAssetType.STABLECOIN});

enum Fca { EMPTY, EXCHANGE, UTILITY, ASSET, EXCHANGE_UTILITY, UTILITY_ASSET, EXCHANGE_ASSET }

final fcaValues = EnumValues({
  "Asset": Fca.ASSET,
  "": Fca.EMPTY,
  "Exchange": Fca.EXCHANGE,
  "Exchange,Asset": Fca.EXCHANGE_ASSET,
  "Exchange,Utility": Fca.EXCHANGE_UTILITY,
  "Utility": Fca.UTILITY,
  "Utility,Asset": Fca.UTILITY_ASSET
});

enum Finma { EMPTY, PAYMENT, UTILITY, ASSET, PAYMENT_UTILITY, UTILITY_ASSET, PAYMENT_ASSET }

final finmaValues = EnumValues({
  "Asset": Finma.ASSET,
  "": Finma.EMPTY,
  "Payment": Finma.PAYMENT,
  "Payment,Asset": Finma.PAYMENT_ASSET,
  "Payment,Utility": Finma.PAYMENT_UTILITY,
  "Utility": Finma.UTILITY,
  "Utility,Asset": Finma.UTILITY_ASSET
});

enum Industry {
  EMPTY,
  FINANCIAL_AND_INSURANCE_ACTIVITIES,
  BLOCKCHAIN_SPECIFIC_APPLICATION,
  INFORMATION_AND_COMMUNICATION,
  WHOLESALE_AND_RETAIL_TRADE,
  PROFESSIONAL_SCIENTIFIC_AND_TECHNICAL_ACTIVITIES,
  ARTS_ENTERTAINMENT_AND_RECREATION,
  TRANSPORTATION_AND_STORAGE,
  PUBLIC_ADMINISTRATION_AND_DEFENCE
}

final industryValues = EnumValues({
  "Arts, Entertainment and Recreation": Industry.ARTS_ENTERTAINMENT_AND_RECREATION,
  "Blockchain-Specific Application": Industry.BLOCKCHAIN_SPECIFIC_APPLICATION,
  "": Industry.EMPTY,
  "Financial and Insurance Activities": Industry.FINANCIAL_AND_INSURANCE_ACTIVITIES,
  "Information and Communication": Industry.INFORMATION_AND_COMMUNICATION,
  "Professional, Scientific and Technical Activities": Industry.PROFESSIONAL_SCIENTIFIC_AND_TECHNICAL_ACTIVITIES,
  "Public Administration and Defence": Industry.PUBLIC_ADMINISTRATION_AND_DEFENCE,
  "Transportation and Storage": Industry.TRANSPORTATION_AND_STORAGE,
  "Wholesale and Retail Trade": Industry.WHOLESALE_AND_RETAIL_TRADE
});

class RateLimit extends Equatable {
  RateLimit();

  factory RateLimit.fromJson(Map<String, dynamic> json) => RateLimit();

  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [];
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
