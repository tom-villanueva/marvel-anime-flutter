import 'package:actividad_05/routes.dart';
import 'package:actividad_05/screens/home/anime_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PaginatedAnimeUpcomingScreen extends StatelessWidget {
  PaginatedAnimeUpcomingScreen({Key key}) : super(key: key);

  final String queryAnimeTab = """
    query (\$page: Int, \$nextSeason: MediaSeason, \$nextYear: Int) {
      nextSeason: Page(page: \$page, perPage: 20) {
        pageInfo {
          currentPage
          hasNextPage
        }
        media(season: \$nextSeason, seasonYear: \$nextYear, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
          id
          title {
            userPreferred
          }
          coverImage {
            large
          }
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(queryAnimeTab),
            variables: {
              "page": 1,
              "nextSeason": "SUMMER",
              "nextYear": 2021,
            },
            fetchPolicy: FetchPolicy.noCache
          ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
               
          int pageToFetch = 1;
          bool hasNextPage = true;

          if (result.data != null) {
            pageToFetch = result.data['nextSeason']['pageInfo']['currentPage'] + 1;   
            hasNextPage = result.data['nextSeason']['pageInfo']['hasNextPage'];
          }

          if (result.hasException) {
            print(result.exception);
            return Text(result.exception.toString());
          }

          if (result.isLoading && result.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //nextSeason
          return Scaffold(
            body: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    icon: Icon(Icons.arrow_back),
                    iconSize: 35.0,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 75),
                    child: Text('Next season', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: result.data["nextSeason"]["media"].length + 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ROUTE_NAMES['ANIME_DETAIL'],
                                arguments: result.data["nextSeason"]["media"][index]);
                          },
                          child: index == result.data["nextSeason"]["media"].length 
                                ? ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Ver más"),
                                      ],
                                    ),
                                    onPressed: hasNextPage ? 
                                    () => fetchMore(
                                      FetchMoreOptions.partial(
                                        variables: {'page': pageToFetch},
                                        updateQuery: (existing, newAnimes) => ({
                                          'nextSeason': {
                                            'pageInfo': newAnimes['nextSeason']['pageInfo'],
                                            'media': [
                                              ...existing['nextSeason']['media'],
                                              ...newAnimes['nextSeason']['media']
                                            ],
                                          }
                                        }),
                                      ),
                                    ) 
                                    : null
                                  )
                                : AnimeCard(media: result.data["nextSeason"]["media"][index]));
                      }),
                ),
              ), 
              (result.isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Icon(Icons.arrow_downward)
            ],
          )
          );
        });
  }
}