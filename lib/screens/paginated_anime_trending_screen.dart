import 'package:actividad_05/routes.dart';
import 'package:actividad_05/screens/home/anime_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PaginatedAnimeTrendingScreen extends StatelessWidget {
  PaginatedAnimeTrendingScreen({Key key}) : super(key: key);

  final String queryAnimeTab = """
    query (\$page: Int) {
      trending: Page(page: \$page, perPage: 20) {
        pageInfo {
          currentPage
          hasNextPage
        }
        media(sort: TRENDING_DESC, type: ANIME, isAdult: false) {
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
              "page": 1
            },
            fetchPolicy: FetchPolicy.noCache
          ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {

          int pageToFetch = 1;
          bool hasNextPage = true;

          if (result.data != null) {
            pageToFetch = result.data['trending']['pageInfo']['currentPage'] + 1;   
            hasNextPage = result.data['trending']['pageInfo']['hasNextPage'];
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

          //trending
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
                child: Text('Trending NOW', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
              ),
            ],
          ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: result.data["trending"]["media"].length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ROUTE_NAMES['ANIME_DETAIL'],
                                arguments: result.data["trending"]["media"][index]);
                          },
                          child: AnimeCard(media: result.data["trending"]["media"][index]));
                      }),
                ),
              ), 
              (result.isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
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
                      'trending': {
                        'pageInfo': newAnimes['trending']['pageInfo'],
                        'media': [
                          ...existing['trending']['media'],
                          ...newAnimes['trending']['media']
                        ],
                      }
                    }),
                  ),
                ) 
                : null
              )
            ],
          )
          );
        });
  }
}