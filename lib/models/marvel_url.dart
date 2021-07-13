import 'dart:convert';

import 'package:actividad_05/utils/enum_values.dart';

class MarvelUrl {
  MarvelUrl({
    this.type,
    this.url,
  });

  MarvelUrlType type;
  String url;

  factory MarvelUrl.fromRawJson(String str) =>
      MarvelUrl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarvelUrl.fromJson(Map<String, dynamic> json) => MarvelUrl(
        type: urlTypeValues.map[json["type"]],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
      };
}

enum MarvelUrlType { DETAIL, WIKI, COMICLINK }

final urlTypeValues = EnumValues({
  "comiclink": MarvelUrlType.COMICLINK,
  "detail": MarvelUrlType.DETAIL,
  "wiki": MarvelUrlType.WIKI
});
