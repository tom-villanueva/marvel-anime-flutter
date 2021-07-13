import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/home/widgets/serie_hero.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:flutter/material.dart';

class SerieHeroList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        child: FutureBuilder<MarvelResponse<Serie>>(
          future: MarvelApiService().getAllSeries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.count,
                  itemBuilder: (BuildContext context, index) {
                    return SerieHero(serie: snapshot.data.data.results[index]);
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
