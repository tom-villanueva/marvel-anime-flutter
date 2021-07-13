import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/screens/home/widgets/entity_detail_screen.dart';
import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Character character = ModalRoute.of(context).settings.arguments as Character;
    return EntityDetailScreen(
      entity: character, 
      sharedKey: "favouriteCharacters",
      name: character.name,
      description: character.description,  
      type: Character,
    );
  }
}