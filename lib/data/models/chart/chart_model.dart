// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);
import 'dart:convert';

import 'package:equatable/equatable.dart';

ChartModel chartModelFromJson({String str}) => ChartModel.fromJson(json.decode(str));

String chartModelToJson(ChartModel data) => json.encode(data.toJson());

class ChartModel extends Equatable {
  ChartModel({
    this.response,
    this.message,
    this.hasWarning,
    this.type,
    this.rateLimit,
    this.data,
  });

  final String response;
  final String message;
  final bool hasWarning;
  final int type;
  final RateLimit rateLimit;
  final Data data;

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        response: json["Response"],
        message: json["Message"],
        hasWarning: json["HasWarning"],
        type: json["Type"],
        rateLimit: RateLimit.fromJson(json["RateLimit"]),
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Response": response,
        "Message": message,
        "HasWarning": hasWarning,
        "Type": type,
        "RateLimit": rateLimit.toJson(),
        "Data": data.toJson(),
      };

  @override
  List<Object> get props => [
        data,
        rateLimit,
        type,
        response,
        message,
        hasWarning,
      ];
}

class Data extends Equatable {
  Data({
    this.aggregated,
    this.timeFrom,
    this.timeTo,
    this.data,
  });

  final bool aggregated;
  final int timeFrom;
  final int timeTo;
  final List<Datum> data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aggregated: json["Aggregated"],
        timeFrom: json["TimeFrom"],
        timeTo: json["TimeTo"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Aggregated": aggregated,
        "TimeFrom": timeFrom,
        "TimeTo": timeTo,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        aggregated,
        timeTo,
        timeFrom,
        data,
      ];
}

class Datum extends Equatable {
  Datum({
    this.time,
    this.close,
    this.high,
    this.low,
    this.open,
    this.volumefrom,
    this.volumeto,
    this.conversionType,
    this.conversionSymbol,
  });

  final int time;
  final double close;
  final double high;
  final double low;
  final double open;
  final double volumefrom;
  final double volumeto;
  final ConversionType conversionType;
  final String conversionSymbol;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        time: json["time"],
        close: json["close"].toDouble(),
        high: json["high"].toDouble(),
        low: json["low"].toDouble(),
        open: json["open"].toDouble(),
        volumefrom: json["volumefrom"].toDouble(),
        volumeto: json["volumeto"].toDouble(),
        conversionType: conversionTypeValues.map[json["conversionType"]],
        conversionSymbol: json["conversionSymbol"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "close": close,
        "high": high,
        "low": low,
        "open": open,
        "volumefrom": volumefrom,
        "volumeto": volumeto,
        "conversionType": conversionTypeValues.reverse[conversionType],
        "conversionSymbol": conversionSymbol,
      };
  @override
  List<Object> get props => [
        time,
        close,
        high,
        low,
        open,
        volumeto,
        volumefrom,
        conversionType,
        conversionSymbol,
      ];
}

enum ConversionType { FORCE_DIRECT }

final conversionTypeValues = EnumValues({"force_direct": ConversionType.FORCE_DIRECT});

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
