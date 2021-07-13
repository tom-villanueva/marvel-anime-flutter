import 'package:actividad_05/models/marvel_url.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/utils/enum_values.dart';

class Comic {
  Comic({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.diamondCode,
    this.ean,
    this.issn,
    this.format,
    this.pageCount,
    // this.textObjects,
    this.resourceUri,
    this.urls,
    // this.series,
    // this.variants,
    // this.collections,
    // this.collectedIssues,
    // this.dates,
    // this.prices,
    this.thumbnail,
    this.images,
    // this.creators,
    // this.characters,
    // this.stories,
    // this.events,
  });

  int id;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  Format format;
  int pageCount;
  // List<TextObject> textObjects;
  String resourceUri;
  List<MarvelUrl> urls;
  // List<Series> variants;
  // List<Series> collections;
  // List<Series> collectedIssues;
  // List<Date> dates;
  // List<Price> prices;
  Thumbnail thumbnail;
  List<Thumbnail> images;
  // Creators creators;
  // Characters characters;
  // Stories stories;
  // Characters events;

  factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"] == null ? '' : json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: formatValues.map[json["format"]],
        pageCount: json["pageCount"],
        // textObjects: List<TextObject>.from(
        //     json["textObjects"].map((x) => TextObject.fromJson(x))),
        resourceUri: json["resourceURI"],
        urls: List<MarvelUrl>.from(
            json["urls"].map((x) => MarvelUrl.fromJson(x))),
        // series: Series.fromJson(json["series"]),
        // variants:
        //     List<Series>.from(json["variants"].map((x) => Series.fromJson(x))),
        // collections: List<Series>.from(
        //     json["collections"].map((x) => Series.fromJson(x))),
        // collectedIssues: List<Series>.from(
        //     json["collectedIssues"].map((x) => Series.fromJson(x))),
        // dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        // prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromJson(x))),
        // creators: Creators.fromJson(json["creators"]),
        // characters: Characters.fromJson(json["characters"]),
        // stories: Stories.fromJson(json["stories"]),
        // events: Characters.fromJson(json["events"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description == null ? '' : description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": formatValues.reverse[format],
        "pageCount": pageCount,
        // "textObjects": List<dynamic>.from(textObjects.map((x) => x.toJson())),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        // "series": series.toJson(),
        // "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        // "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
        // "collectedIssues":
        //     List<dynamic>.from(collectedIssues.map((x) => x.toJson())),
        // "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        // "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        // "creators": creators.toJson(),
        // "characters": characters.toJson(),
        // "stories": stories.toJson(),
        // "events": events.toJson(),
      };
}

enum Format { COMIC, INFINITE_COMIC, TRADE_PAPERBACK, HARDCOVER }

final formatValues = EnumValues({
  "Comic": Format.COMIC,
  "Hardcover": Format.HARDCOVER,
  "Infinite Comic": Format.INFINITE_COMIC,
  "Trade Paperback": Format.TRADE_PAPERBACK
});
