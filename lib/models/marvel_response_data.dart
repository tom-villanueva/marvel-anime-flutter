import 'dart:convert';

import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/serie.dart';

class MarvelResponseData<T> {
  MarvelResponseData({
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  });

  int offset;
  int limit;
  int total;
  int count;
  List<T> results;

  factory MarvelResponseData.fromRawJson(String str) =>
      MarvelResponseData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarvelResponseData.fromJson(Map<String, dynamic> json) =>
      MarvelResponseData(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<T>.from(json["results"].map((item) {
          if (T == Character) {
            return Character.fromJson(item);
          } else if (T == Serie) {
            return Serie.fromJson(item);
          } else if (T == Comic) {
            return Comic.fromJson(item);
          } else if (T == MarvelEvent) {
            return MarvelEvent.fromJson(item);
          } else if (T == Creator) {
            return Creator.fromJson(item);
          } else {
            throw Exception('Type not supported');
          }
        })),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((item) {
          if (T == Character) {
            return (item as Character).toJson();
          } else if (T == Serie) {
            return (item as Serie).toJson();
          } else if (T == Comic) {
            return (item as Comic).toJson();
          } else if (T == MarvelEvent) {
            return (item as MarvelEvent).toJson();
          } else if (T == Creator) {
            return (item as Creator).toJson();
          } else {
            throw Exception('Type not supported');
          }
        })),
      };
}
