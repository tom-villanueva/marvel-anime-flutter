import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/widgets/thumb_hero_implementation.dart';
import 'package:flutter/material.dart';

class ThumbHero extends StatelessWidget {
  const ThumbHero({
    Key key,
    @required this.thumb,
  }) : super(key: key);

  final Thumbnail thumb;

  @override
  Widget build(BuildContext context) {
    return ThumbHeroImplementation(thumb: thumb);
  }
}
