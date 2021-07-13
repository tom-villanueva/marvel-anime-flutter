import 'dart:async';

import 'package:actividad_05/bloc/favorite_results_cubit.dart';
import 'package:actividad_05/bloc/favorite_results_state.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/screens/home/anime_tab_screen.dart';
import 'package:actividad_05/widgets/text_with_icon.dart';
import 'package:actividad_05/widgets/thumb_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FavsTabScreen extends StatefulWidget {
  const FavsTabScreen({Key key}) : super(key: key);

  @override
  _FavsTabScreenState createState() => _FavsTabScreenState();

}

final animeQuery = r"""
  query ($id_in: [Int], $perPage: Int) {
  favorites: Page(page: 1, perPage: $perPage) {
    media(id_in: $id_in, type: ANIME, isAdult: false) {
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
class _FavsTabScreenState extends State<FavsTabScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteResultsCubit>(context).getAllEntitiesByIds();
  }

  void refreshCubit() { 
    BlocProvider.of<FavoriteResultsCubit>(context).getAllEntitiesByIds();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FavoriteResultsCubit, FavoriteResultsState>(
          builder: (context, state) {
            if (state is FavoriteResultsFetchingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteResultsFailureState) {
              return Text('ERROR');
            } else {
              final comics = state.comicFavorites;
              final events = state.eventFavorites;
              final series = state.serieFavorites;
              final creators = state.creatorFavorites;
              final characters = state.characterFavorites;
              return Container(
                height: 550,
                child: ListView(
                  children: [
                    FavoriteList(
                      entities: characters, 
                      label: "Favorited characters", 
                      routeName: 'CHARACTER_DETAIL', 
                      refreshCubit: refreshCubit
                    ),
                    FavoriteList(
                      entities: comics, 
                      label: "Favorited comics", 
                      routeName: 'COMIC_DETAIL', 
                      refreshCubit: refreshCubit
                    ),
                    FavoriteList(
                      entities: events, 
                      label: "Favorited events", 
                      routeName: 'EVENT_DETAIL', 
                      refreshCubit: refreshCubit
                    ),
                    FavoriteList(
                      entities: series, 
                      label: "Favorited series", 
                      routeName: 'SERIE_DETAIL', 
                      refreshCubit: refreshCubit
                    ),
                    FavoriteList(
                      entities: creators, 
                      label: "Favorited creators", 
                      routeName: 'CREATOR_DETAIL', 
                      refreshCubit: refreshCubit
                    ),
                    Query(
                      options: QueryOptions(
                          document: gql(animeQuery),
                          variables: {
                            "id_in": state.animeFavorites,
                            "perPage": state.animeFavorites.length,
                          },
                          fetchPolicy: FetchPolicy.noCache),
                      builder: (QueryResult result,
                          {VoidCallback refetch, FetchMore fetchMore}) {
                        if (result.hasException) {
                          print(result.exception);
                          return Text(result.exception.toString());
                        }

                        if (result.isLoading) {
                          return Center(                                                                                                                                                                                                                                                             
                            child: CircularProgressIndicator(),                                                                                                                                                                                                                                      
                          );
                        }

                        return AnimeCardList(
                          label: 'Favorited animes',
                          media: result.data['favorites']['media'],
                          refresh: refreshCubit,
                        );
                      }),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    Key key,
    @required this.entities,
    @required this.label,
    @required this.routeName,
    @required this.refreshCubit,
  }) : super(key: key);

  final List<dynamic> entities;
  final String label;
  final String routeName;
  final Function refreshCubit;

  FutureOr ref(dynamic value) {
    refreshCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWithIcon(label: label),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: entities.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ROUTE_NAMES[routeName],
                      arguments: entities[index]).then(this.ref);
                },
                child: ThumbHero(thumb: entities[index].thumbnail)
              );
              }
            ),
        ),
      ],
    );
  }
}
