import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/screens/home/widgets/entity_generic_list.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class EventRelatedContent extends StatelessWidget {
  const EventRelatedContent({Key key, @required this.event})
      : super(key: key);

  final MarvelEvent event;

  @override
  Widget build(BuildContext context) {
    return Column(children: [      
      EntityGenericList(
        entity: event, 
        request: MarvelApiService().getEventCharactes, 
        routeName: 'CHARACTER_DETAIL', 
        label: 'Related characters'
      ),
      EntityGenericList(
        entity: event, 
        request: MarvelApiService().getEventSeries, 
        routeName: 'SERIE_DETAIL', 
        label: 'Related series'
      ),
      EntityGenericList(
        entity: event, 
        request: MarvelApiService().getEventComics, 
        routeName: 'COMIC_DETAIL', 
        label: 'Related comics'
      ),
      EntityGenericList(
        entity: event, 
        request: MarvelApiService().getEventCreators, 
        routeName: 'CREATOR_DETAIL', 
        label: 'Related creators'
      ),
    ]);
  }
}