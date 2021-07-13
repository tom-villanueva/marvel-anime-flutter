import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/screens/home/widgets/entity_generic_list.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class ComicRelatedContent extends StatelessWidget {
  const ComicRelatedContent({Key key, @required this.comic})
      : super(key: key);

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Column(children: [  
      EntityGenericList(
        entity: comic, 
        request: MarvelApiService().getComicCharactes, 
        routeName: 'CHARACTER_DETAIL', 
        label: 'Related characters'
      ),
      EntityGenericList(
        entity: comic, 
        request: MarvelApiService().getComicEvents, 
        routeName: 'EVENT_DETAIL', 
        label: 'Related events'
      ),
      EntityGenericList(
        entity: comic, 
        request: MarvelApiService().getComicCreators, 
        routeName: 'CREATOR_DETAIL', 
        label: 'Related creators'
      ),      
    ]);
  }
}

