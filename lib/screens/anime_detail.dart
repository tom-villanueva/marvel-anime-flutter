import 'package:flutter/material.dart';

import 'anime_detail_screen.dart';

class AniDetailScreen extends StatelessWidget {
  const AniDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic anime = ModalRoute.of(context).settings.arguments;
    return AnimeDetailScreen(
      entity: anime,
    );
  }
}