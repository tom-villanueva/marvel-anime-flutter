import 'package:actividad_05/models/thumbnail.dart';
import 'package:actividad_05/widgets/text_with_icon.dart';
import 'package:actividad_05/widgets/thumb_hero.dart';
import 'package:flutter/material.dart';

class LabeledImageList extends StatelessWidget {
  const LabeledImageList({Key key, this.label, this.thumbs, this.onTap})
      : super(key: key);

  final String label;
  final List<Thumbnail> thumbs;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextWithIcon(label: label),
        Container(
            height:
                thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_MEDIUM].height,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: thumbs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: onTap(index),
                      child: ThumbHero(thumb: thumbs[index]));
                }))
      ],
    );
  }
}
