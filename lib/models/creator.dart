import 'package:actividad_05/models/marvel_url.dart';
import 'package:actividad_05/models/thumbnail.dart';

class Creator {
  Creator({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.fullName,
    this.modified,
    this.thumbnail,
    this.resourceUri,
    // this.comics,
    // this.series,
    // this.stories,
    // this.events,
    this.urls,
  });

  int id;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String fullName;
  String modified;
  Thumbnail thumbnail;
  String resourceUri;
  // Comics comics;
  // Comics series;
  // Stories stories;
  // Comics events;
  List<MarvelUrl> urls;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        suffix: json["suffix"],
        fullName: json["fullName"],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        resourceUri: json["resourceURI"],
        // comics: Comics.fromJson(json["comics"]),
        // series: Comics.fromJson(json["series"]),
        // stories: Stories.fromJson(json["stories"]),
        // events: Comics.fromJson(json["events"]),
        urls: List<MarvelUrl>.from(
            json["urls"].map((x) => MarvelUrl.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "suffix": suffix,
        "fullName": fullName,
        "modified": modified,
        "thumbnail": thumbnail.toJson(),
        "resourceURI": resourceUri,
        // "comics": comics.toJson(),
        // "series": series.toJson(),
        // "stories": stories.toJson(),
        // "events": events.toJson(),
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
      };
}
