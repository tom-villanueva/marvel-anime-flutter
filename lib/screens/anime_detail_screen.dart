import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_database/firebase_database.dart';

final ANIME_DETAIL_QUERY = r"""
query media($id: Int, $type: MediaType, $isAdult: Boolean) {
  Media(id: $id, type: $type, isAdult: $isAdult) {
    id
    title {
      userPreferred
      romaji
      english
      native
    }
    coverImage {
      extraLarge
      large
    }
    bannerImage
    startDate {
      year
      month
      day
    }
    endDate {
      year
      month
      day
    }
    description
    season
    seasonYear
    type
    format
    status(version: 2)
    episodes
    duration
    chapters
    volumes
    genres
    synonyms
    source(version: 2)
    isAdult
    isLocked
    meanScore
    averageScore
    popularity
    favourites
    hashtag
    countryOfOrigin
    isLicensed
    isFavourite
    isRecommendationBlocked
    nextAiringEpisode {
      airingAt
      timeUntilAiring
      episode
    }
    relations {
      edges {
        id
        relationType(version: 2)
        node {
          id
          title {
            userPreferred
          }
          format
          type
          status(version: 2)
          bannerImage
          coverImage {
            large
          }
        }
      }
    }
    characterPreview: characters(perPage: 6, sort: [ROLE, RELEVANCE, ID]) {
      edges {
        id
        role
        name
        voiceActors(language: JAPANESE, sort: [RELEVANCE, ID]) {
          id
          name {
            full
          }
          language: languageV2
          image {
            large
          }
        }
        node {
          id
          name {
            full
          }
          image {
            large
          }
        }
      }
    }
    staffPreview: staff(perPage: 8, sort: [RELEVANCE, ID]) {
      edges {
        id
        role
        node {
          id
          name {
            full
          }
          language: languageV2
          image {
            large
          }
        }
      }
    }
    studios {
      edges {
        isMain
        node {
          id
          name
        }
      }
    }
    reviewPreview: reviews(perPage: 2, sort: [RATING_DESC, ID]) {
      pageInfo {
        total
      }
      nodes {
        id
        summary
        rating
        ratingAmount
        user {
          id
          name
          avatar {
            large
          }
        }
      }
    }
    recommendations(perPage: 7, sort: [RATING_DESC, ID]) {
      pageInfo {
        total
      }
      nodes {
        id
        rating
        userRating
        mediaRecommendation {
          id
          title {
            userPreferred
          }
          format
          type
          status(version: 2)
          bannerImage
          coverImage {
            large
          }
        }
        user {
          id
          name
          avatar {
            large
          }
        }
      }
    }
    externalLinks {
      site
      url
    }
    streamingEpisodes {
      site
      title
      thumbnail
      url
    }
    trailer {
      id
      site
    }
    rankings {
      id
      rank
      type
      format
      year
      season
      allTime
      context
    }
    tags {
      id
      name
      description
      rank
      isMediaSpoiler
      isGeneralSpoiler
    }
    mediaListEntry {
      id
      status
      score
    }
    stats {
      statusDistribution {
        status
        amount
      }
      scoreDistribution {
        score
        amount
      }
    }
  }
}
""";

class AnimeDetailScreen extends StatefulWidget {
  const AnimeDetailScreen({Key key, this.anime, this.entity}) : super(key: key);

  final String anime;
  final dynamic entity; 

  @override
  _AnimeDetailScreenState createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  List<dynamic> favouritedAnimeIds = [];
  double starsRating = 0.0;
  final database = FirebaseDatabase.instance.ref(); 

  toggleFavourite(int animeId) => () async {
        setState(() {
          if (favouritedAnimeIds.indexOf(animeId) >= 0) {
            favouritedAnimeIds.remove(animeId);
          } else {
            favouritedAnimeIds.add(animeId);
          }
        });

        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String favouriteAnimes = prefs.getString('favouriteAnimes') ?? '[]';

          // print('From sharedProps $favouriteAnimes');

          List<dynamic> favouriteAnimesIds = json.decode(favouriteAnimes);

          if (favouriteAnimesIds.indexOf(animeId) >= 0) {
            favouriteAnimesIds.remove(animeId);
          } else {
            favouriteAnimesIds.add(animeId);
          }

          await prefs.setString(
              'favouriteAnimes', json.encode(favouriteAnimesIds));
        } catch (e) {
          print('Err $e');
          SharedPreferences.setMockInitialValues({});
        }
      };

  getFavouriteAnimes() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String favouriteAnimes = prefs.getString('favouriteAnimes') ?? '[]';
      List<dynamic> animeFavourites = json.decode(favouriteAnimes);

      // print('From INIT STATE $animeFavourites');
      setState(() {
        favouritedAnimeIds = animeFavourites;
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  }

  Expanded listTiles(String title, String subTitle) {
    return Expanded(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
      ),
    );
  }

  getEntityPath() {
    int widgetId = widget.entity['id'];
    return '/animes/$widgetId/stars';
  }

  getOrCreateStarsRating() async {
    DatabaseReference ref = database.child(getEntityPath());

    DatabaseEvent event = await ref.once();

    print('value: ');
    print(event.snapshot.value);

    if(event.snapshot.value == null) {
      ref.set(0.0);//{'stars': 0.0});
      starsRating = 0.0;
    } else {
      starsRating = event.snapshot.value;
    }

    print('rating: ' + starsRating.toString());

  }

  @override
  void initState() {
    super.initState();
    getFavouriteAnimes();
    getOrCreateStarsRating();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic anime = ModalRoute.of(context).settings.arguments;
    final starsRef = database.child(getEntityPath());

    return Scaffold(
        body: graphql.Query(
            options: graphql.QueryOptions(
                document: graphql.gql(ANIME_DETAIL_QUERY),
                variables: {
                  "id": anime["id"],
                  "type": "ANIME",
                  "isAdult": false
                },
                fetchPolicy: graphql.FetchPolicy.noCache),
            builder: (graphql.QueryResult result,
                {VoidCallback refetch, graphql.FetchMore fetchMore}) {
              if (result.hasException) {
                print(result.exception);
                return Text(result.exception.toString());
              }

              if (result.isLoading) {
                return Text('Loading...');
              }

              final dynamic anime = result.data['Media'];

              return ListView(
                children: [
                  IconButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    icon: Icon(Icons.arrow_back),
                    iconSize: 35.0,
                    color: Colors.black,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(60, 40),
                          bottomRight: Radius.elliptical(60, 40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.9),
                          blurRadius: 0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(anime['coverImage']['extraLarge']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: 500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: toggleFavourite(anime['id']),
                        icon: (favouritedAnimeIds.indexOf(anime["id"]) >= 0)
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_outline),
                        iconSize: 40.0,
                        color: Colors.black,
                      ),
                      IconButton(
                        onPressed: () {
                          String animeName = anime['title']['userPreferred'];
                          Share.share(
                            "Checkout this anime $animeName",
                          );
                        },
                        icon: Icon(Icons.share),
                        iconSize: 35.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        anime['title']['userPreferred'].toUpperCase(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.0),
                      RatingBar.builder(
                        initialRating: starsRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          starsRef.set(rating);
                        },
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        height: 120.0,
                        child: SingleChildScrollView(
                          child: Text(
                            anime['description'] != null
                                ? anime['description'].replaceAll('<br>', '\n')
                                : 'No description',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          listTiles(
                              'Airing',
                              anime['nextAiringEpisode'] != null
                                  ? (anime['nextAiringEpisode']['episode']
                                          .toString() +
                                      ': ' +
                                      DateFormat("MM/dd/yyyy").format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              anime['nextAiringEpisode']
                                                      ['airingAt'] *
                                                  1000)))
                                  : '-'),
                          listTiles('Format', anime['format'] ?? 'Error?'),
                        ],
                      ),
                      Row(
                        children: [
                          listTiles(
                              'Episode Duration',
                              anime['duration'] != null
                                  ? anime['duration'].toString()
                                  : '-'),
                          listTiles('Status', anime['status'] ?? '-'),
                        ],
                      ),
                      Row(
                        children: [
                          listTiles(
                              'Start Date',
                              anime['startDate'] != null
                                  ? (anime['startDate']['month'].toString() +
                                      '/' +
                                      anime['startDate']['day'].toString() +
                                      '/' +
                                      anime['startDate']['year'].toString())
                                  : '-'),
                          listTiles(
                              'Season',
                              anime['season'] +
                                  ' ' +
                                  anime['seasonYear'].toString()),
                        ],
                      ),
                      Row(
                        children: [
                          listTiles(
                              'Average Score',
                              anime['averageScore'] != null
                                  ? anime['averageScore'].toString()
                                  : '-'),
                          listTiles(
                              'Mean Score',
                              anime['meanScore'] != null
                                  ? anime['meanScore'].toString()
                                  : '-'),
                        ],
                      ),
                      Row(
                        children: [
                          listTiles(
                              'Popularity',
                              anime['popularity'] != null
                                  ? anime['popularity'].toString()
                                  : '-'),
                          listTiles(
                              'Favorites',
                              anime['favourites'] != null
                                  ? anime['favourites'].toString()
                                  : '-'),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }));
  }
}

class BtnFavourite extends StatelessWidget {
  const BtnFavourite({Key key, this.active}) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Icon(
      active ? Icons.favorite : Icons.favorite_outline,
      color: active ? Colors.red.shade300 : Colors.black,
      size: 30.0,
    );
  }
}
