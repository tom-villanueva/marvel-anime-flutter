import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/screens/home/widgets/entity_generic_list.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class CreatorRelatedContent extends StatelessWidget {
  const CreatorRelatedContent({Key key, @required this.creator})
      : super(key: key);

  final Creator creator;

  @override
  Widget build(BuildContext context) {
    return Column(children: [ 
      EntityGenericList(
        entity: creator, 
        request: MarvelApiService().getCreatorSeries, 
        routeName: 'SERIE_DETAIL', 
        label: 'Related series'
      ),
      EntityGenericList(
        entity: creator, 
        request: MarvelApiService().getCreatorEvents, 
        routeName: 'EVENT_DETAIL', 
        label: 'Related events'
      ),  
      EntityGenericList(
        entity: creator, 
        request: MarvelApiService().getCreatorComics, 
        routeName: 'COMIC_DETAIL', 
        label: 'Related comics'
      ),       
    ]);
  }
}
