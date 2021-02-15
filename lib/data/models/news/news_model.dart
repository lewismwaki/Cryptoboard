// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);
import 'dart:convert';

import 'package:equatable/equatable.dart';

News newsFromJson({String str}) => News.fromJson(json.decode(str));

String newsToJson({News data}) => json.encode(data.toJson());

class News extends Equatable {
  News({
    this.type,
    this.message,
    this.promoted,
    this.data,
    this.rateLimit,
    this.hasWarning,
  });

  final int type;
  final String message;
  final List<dynamic> promoted;
  final List<Datum> data;
  final RateLimit rateLimit;
  final bool hasWarning;

  factory News.fromJson(Map<String, dynamic> json) => News(
        type: json["Type"],
        message: json["Message"],
        promoted: List<dynamic>.from(json["Promoted"].map((x) => x)),
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        rateLimit: RateLimit.fromJson(json["RateLimit"]),
        hasWarning: json["HasWarning"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "Message": message,
        "Promoted": List<dynamic>.from(promoted.map((x) => x)),
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "RateLimit": rateLimit.toJson(),
        "HasWarning": hasWarning,
      };

  @override
  List<Object> get props => [type, message, data, rateLimit, hasWarning, promoted];
}

class Datum extends Equatable {
  Datum({
    this.id,
    this.guid,
    this.publishedOn,
    this.imageurl,
    this.title,
    this.url,
    this.source,
    this.body,
    this.tags,
    this.categories,
    this.upvotes,
    this.downvotes,
    this.lang,
    this.sourceInfo,
  });

  final String id;
  final String guid;
  final int publishedOn;
  final String imageurl;
  final String title;
  final String url;
  final String source;
  final String body;
  final String tags;
  final String categories;
  final String upvotes;
  final String downvotes;
  final Lang lang;
  final SourceInfo sourceInfo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        guid: json["guid"],
        publishedOn: json["published_on"],
        imageurl: json["imageurl"],
        title: json["title"],
        url: json["url"],
        source: json["source"],
        body: json["body"],
        tags: json["tags"],
        categories: json["categories"],
        upvotes: json["upvotes"],
        downvotes: json["downvotes"],
        lang: langValues.map[json["lang"]],
        sourceInfo: SourceInfo.fromJson(json["source_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "published_on": publishedOn,
        "imageurl": imageurl,
        "title": title,
        "url": url,
        "source": source,
        "body": body,
        "tags": tags,
        "categories": categories,
        "upvotes": upvotes,
        "downvotes": downvotes,
        "lang": langValues.reverse[lang],
        "source_info": sourceInfo.toJson(),
      };

  @override
  List<Object> get props =>
      [id, guid, publishedOn, imageurl, title, url, source, sourceInfo, body, tags, categories, upvotes, downvotes, lang, sourceInfo];
}

enum Lang { EN }

final langValues = EnumValues({"EN": Lang.EN});

class SourceInfo extends Equatable {
  SourceInfo({
    this.name,
    this.lang,
    this.img,
  });

  final String name;
  final Lang lang;
  final String img;

  factory SourceInfo.fromJson(Map<String, dynamic> json) => SourceInfo(
        name: json["name"],
        lang: langValues.map[json["lang"]],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lang": langValues.reverse[lang],
        "img": img,
      };

  @override
  List<Object> get props => [name, lang, img];
}

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
