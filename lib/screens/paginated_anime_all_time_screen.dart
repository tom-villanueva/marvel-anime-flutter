import 'package:actividad_05/routes.dart';
import 'package:actividad_05/screens/home/anime_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PaginatedAnimeAllTimeScreen extends StatelessWidget {
  PaginatedAnimeAllTimeScreen({Key key}) : super(key: key);

  final String queryAnimeTab = """
    query (\$page: Int) {
      popular: Page(page: \$page, perPage: 20) {
        pageInfo {
          currentPage
          hasNextPage
        }
        media(sort: POPULARITY_DESC, type: ANIME, isAdult: false) {
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
            },
            fetchPolicy: FetchPolicy.noCache
          ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
               
          int pageToFetch = 1;
          bool hasNextPage = true;

          if (result.data != null) {
            pageToFetch = result.data['popular']['pageInfo']['currentPage'] + 1;   
            hasNextPage = result.data['popular']['pageInfo']['hasNextPage'];
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

          //popular
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
                    child: Text('All time popular', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: result.data["popular"]["media"].length + 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ROUTE_NAMES['ANIME_DETAIL'],
                                arguments: result.data["popular"]["media"][index]);
                          },
                          child: index == result.data["popular"]["media"].length 
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
                                          'popular': {
                                            'pageInfo': newAnimes['popular']['pageInfo'],
                                            'media': [
                                              ...existing['popular']['media'],
                                              ...newAnimes['popular']['media']
                                            ],
                                          }
                                        }),
                                      ),
                                    ) 
                                    : null
                                  )
                                : AnimeCard(media: result.data["popular"]["media"][index]));
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