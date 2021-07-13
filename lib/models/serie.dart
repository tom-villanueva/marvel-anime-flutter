import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_url.dart';
import 'package:actividad_05/utils/enum_values.dart';

class Serie {
  Serie({
    this.id,
    this.title,
    this.description,
    this.resourceUri,
    this.urls,
    this.startYear,
    this.endYear,
    this.rating,
    this.type,
    this.modified,
    this.thumbnail,
    // this.creators,
    // this.characters,
    // this.stories,
    // this.comics,
    // this.events,
    // this.next,
    // this.previous,
  });

  int id;
  String title;
  String description;
  String resourceUri;
  List<MarvelUrl> urls;
  int startYear;
  int endYear;
  String rating;
  SerieType type;
  String modified;
  Thumbnail thumbnail;
  // Creators creators;
  // Characters characters;
  // Stories stories;
  // Characters comics;
  // Characters events;
  // Next next;
  // dynamic previous;

  factory Serie.fromJson(Map<String, dynamic> json) => Serie(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? '' : json["description"],
        resourceUri: json["resourceURI"],
        urls: List<MarvelUrl>.from(
            json["urls"].map((x) => MarvelUrl.fromJson(x))),
        startYear: json["startYear"],
        endYear: json["endYear"],
        rating: json["rating"],
        type: serieTypeValues.map[json["type"]],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        // creators: Creators.fromJson(json["creators"]),
        // characters: Characters.fromJson(json["characters"]),
        // stories: Stories.fromJson(json["stories"]),
        // comics: Characters.fromJson(json["comics"]),
        // events: Characters.fromJson(json["events"]),
        // next: json["next"] == null ? null : Next.fromJson(json["next"]),
        // previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? '' : description,
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "startYear": startYear,
        "endYear": endYear,
        "rating": rating,
        "type": serieTypeValues.reverse[type],
        "modified": modified,
        "thumbnail": thumbnail.toJson(),
        // "creators": creators.toJson(),
        // "characters": characters.toJson(),
        // "stories": stories.toJson(),
        // "comics": comics.toJson(),
        // "events": events.toJson(),
        // "next": next == null ? null : next.toJson(),
        // "previous": previous,
      };
}

enum SerieType { ONE_SHOT, LIMITED, EMPTY }

final serieTypeValues = EnumValues({
  "": SerieType.EMPTY,
  "limited": SerieType.LIMITED,
  "one shot": SerieType.ONE_SHOT
});
