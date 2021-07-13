import 'package:actividad_05/models/marvel_url.dart';
import 'package:actividad_05/models/thumbnail.dart';

class MarvelEvent {
  MarvelEvent({
    this.id,
    this.title,
    this.description,
    this.resourceUri,
    this.urls,
    this.modified,
    this.start,
    this.end,
    this.thumbnail,
    // this.creators,
    // this.characters,
    // this.stories,
    // this.comics,
    // this.series,
    // this.next,
    // this.previous,
  });

  int id;
  String title;
  String description;
  String resourceUri;
  List<MarvelUrl> urls;
  String modified;
  DateTime start;
  DateTime end;
  Thumbnail thumbnail;
  // Creators creators;
  // Characters characters;
  // Stories stories;
  // Characters comics;
  // Characters series;
  // Next next;
  // Next previous;

  factory MarvelEvent.fromJson(Map<String, dynamic> json) => MarvelEvent(
        id: json["id"],
        title: json["title"],
        description: json["description"] == null ? '' : json["description"],
        resourceUri: json["resourceURI"],
        urls: List<MarvelUrl>.from(
            json["urls"].map((x) => MarvelUrl.fromJson(x))),
        modified: json["modified"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        // creators: Creators.fromJson(json["creators"]),
        // characters: Characters.fromJson(json["characters"]),
        // stories: Stories.fromJson(json["stories"]),
        // comics: Characters.fromJson(json["comics"]),
        // series: Characters.fromJson(json["series"]),
        // next: json["next"] == null ? null : Next.fromJson(json["next"]),
        // previous: json["previous"] == null ? null : Next.fromJson(json["previous"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description == null ? '' : description,
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "modified": modified,
        "start": start == null ? null : start.toIso8601String(),
        "end": end == null ? null : end.toIso8601String(),
        "thumbnail": thumbnail.toJson(),
        // "creators": creators.toJson(),
        // "characters": characters.toJson(),
        // "stories": stories.toJson(),
        // "comics": comics.toJson(),
        // "series": series.toJson(),
        // "next": next == null ? null : next.toJson(),
        // "previous": previous == null ? null : previous.toJson(),
      };
}
