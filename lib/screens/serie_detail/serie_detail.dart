import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/home/widgets/entity_detail_screen.dart';
import 'package:flutter/material.dart';

class SerieDetailScreen extends StatelessWidget {
  const SerieDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Serie serie = ModalRoute.of(context).settings.arguments as Serie;
    return EntityDetailScreen(
      entity: serie, 
      sharedKey: "favouriteSeries",
      name: serie.title,
      description: serie.description, 
      type: Serie, 
    );
  }
}
