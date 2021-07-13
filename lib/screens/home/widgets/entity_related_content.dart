import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/character_detail/character_releated_content.dart';
import 'package:actividad_05/screens/comic_detail/comic_related_content.dart';
import 'package:actividad_05/screens/creator_detail/creator_related_content.dart';
import 'package:actividad_05/screens/event_detail/event_related_content.dart';
import 'package:actividad_05/screens/serie_detail/serie_related_content.dart';
import 'package:flutter/material.dart';

class EntityRelatedContent extends StatelessWidget {
  const EntityRelatedContent(
    {Key key, 
    @required this.entity,
    @required this.type
    })
      : super(key: key);

  final dynamic entity;
  final Type type;

  _getList() {
    if(type == Character){
      return CharacterReleatedContent(character: entity);
    } else if(type == MarvelEvent) {
      return EventRelatedContent(event: entity);
    } else if(type == Comic) {
      return ComicRelatedContent(comic: entity);
    } else if(type == Serie) {
      return SerieRelatedContent(serie: entity);
    } else if(type == Creator) {
      return CreatorRelatedContent(creator: entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getList(),
    );
  }
}