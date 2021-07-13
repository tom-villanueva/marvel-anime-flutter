import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/home/widgets/entity_generic_list.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class SerieRelatedContent extends StatelessWidget {
  const SerieRelatedContent({Key key, @required this.serie})
      : super(key: key);

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      EntityGenericList(
        entity: serie, 
        request: MarvelApiService().getSerieCharactes, 
        routeName: 'CHARACTER_DETAIL', 
        label: 'Related characters'
      ),  
      EntityGenericList(
        entity: serie, 
        request: MarvelApiService().getSerieEvents, 
        routeName: 'EVENT_DETAIL', 
        label: 'Related events'
      ),
      EntityGenericList(
        entity: serie, 
        request: MarvelApiService().getSerieComics, 
        routeName: 'COMIC_DETAIL', 
        label: 'Related comics'
      ),
      EntityGenericList(
        entity: serie, 
        request: MarvelApiService().getSerieCreators, 
        routeName: 'CREATOR_DETAIL', 
        label: 'Related creators'
      ),  
    ]);
  }
}
