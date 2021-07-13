import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';
import 'package:flutter/material.dart';

class EntityGenericList extends StatelessWidget {
  const EntityGenericList({
    Key key, 
    @required this.entity,
    @required this.request,
    @required this.routeName,
    @required this.label,
    }) : super(key: key);

  final dynamic entity;
  final Function request;
  final String routeName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<dynamic>>(
      future: request(entity.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageList(
              onTap: (index) => () => Navigator.pushNamed(
                  context, ROUTE_NAMES[routeName],
                  arguments: snapshot.data.data.results[index]),
              label: label,
              thumbs: snapshot.data.data.results
                  .map<Thumbnail>((item) => item.thumbnail)
                  .toList());
        } else if (snapshot.hasError) {
          return Text('ERROR');
        } else {
          return Text('Cargando...');
        }
      },
    );
  }
}