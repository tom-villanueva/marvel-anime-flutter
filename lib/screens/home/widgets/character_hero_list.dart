import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/screens/home/widgets/character_hero.dart';
import 'package:flutter/material.dart';

class CharacterHeroList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
        child: FutureBuilder<MarvelResponse<Character>>(
          future: MarvelApiService().getAllCharacters(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.count,
                  itemBuilder: (BuildContext context, index) {
                    return CharacterHero(
                        character: snapshot.data.data.results[index]);
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text('ERROR');
            } else {
              return Text('Cargando...');
            }
          },
        ));
  }
}
