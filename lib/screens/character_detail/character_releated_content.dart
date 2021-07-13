import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/screens/character_detail/character_releated_content_implementation.dart';
import 'package:flutter/material.dart';

class CharacterReleatedContent extends StatelessWidget {
  const CharacterReleatedContent({Key key, @required this.character})
      : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return CharacterReleatedContentImplementation(character: character);
  }
}
