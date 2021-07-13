import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/screens/home/widgets/entity_detail_screen.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MarvelEvent event =
        ModalRoute.of(context).settings.arguments as MarvelEvent;
    return EntityDetailScreen(
      entity: event, 
      sharedKey: "favouriteEvents",
      name: event.title,
      description: event.description,  
      type: MarvelEvent,
    );
  }
}
