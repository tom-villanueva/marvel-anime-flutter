import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/labeled_image_list.dart';
import 'package:flutter/material.dart';

class ComicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarvelResponse<Comic>>(
      future: MarvelApiService().getAllComics(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LabeledImageList(
              onTap: (index) => () => Navigator.pushNamed(
                  context, ROUTE_NAMES['COMIC_DETAIL'],
                  arguments: snapshot.data.data.results[index]),
              label: "Last comics",
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
