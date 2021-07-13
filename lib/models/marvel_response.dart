import 'dart:convert';

import 'package:actividad_05/models/marvel_response_data.dart';

class MarvelResponse<T> {
  MarvelResponse({
    this.code,
    this.status,
    this.copyright,
    this.attributionText,
    this.attributionHtml,
    this.etag,
    this.data,
  });

  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  MarvelResponseData<T> data;

  factory MarvelResponse.fromRawJson(String str) =>
      MarvelResponse<T>.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarvelResponse.fromJson(Map<String, dynamic> json) => MarvelResponse(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: MarvelResponseData<T>.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
      };
}
