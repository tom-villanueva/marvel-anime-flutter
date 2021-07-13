import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/screens/home/widgets/entity_generic_list.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class CharacterReleatedContentImplementation extends StatelessWidget {
  const CharacterReleatedContentImplementation({Key key, @required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(children: [  
      EntityGenericList(
        entity: character, 
        request: MarvelApiService().getCharacterSeries, 
        routeName: 'SERIE_DETAIL', 
        label: 'Related series'
      ), 
      EntityGenericList(
        entity: character, 
        request: MarvelApiService().getCharacterComics, 
        routeName: 'COMIC_DETAIL', 
        label: 'Related comics'
      ),
      EntityGenericList(
        entity: character, 
        request: MarvelApiService().getCharacterEvents, 
        routeName: 'EVENT_DETAIL', 
        label: 'Related events'
      ),  
    ]);
  }

}