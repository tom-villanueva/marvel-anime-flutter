import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn_implementation.dart';
import 'package:flutter/material.dart';

class DetailHeroWithBackBtn extends StatelessWidget {
  const DetailHeroWithBackBtn({
    Key key,
    @required this.thumbnail,
  }) : super(key: key);

  final Thumbnail thumbnail;

  @override
  Widget build(BuildContext context) {
    return DetailHeroWithBackBtnImplementation(thumbnail: thumbnail);
  }
}
