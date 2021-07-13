import 'package:flutter/cupertino.dart';

import 'package:actividad_05/models/thumbnail.dart';
import 'package:flutter/material.dart';

class ThumbHeroImplementation extends StatelessWidget {
  const ThumbHeroImplementation({
    Key key,
    @required this.thumb,
  }) : super(key: key);

  final Thumbnail thumb;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_MEDIUM].width,
      decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                offset: Offset(0,4),
                blurRadius: 6,
                color: Colors.black54
              )]
            ),
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              thumb.getSizedThumb(ThumbnailSize.PORTRAIT_UNCANNY),
              fit:BoxFit.cover,
              width: thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_UNCANNY].width,
              height: thumbnailSizeDimensions[ThumbnailSize.PORTRAIT_UNCANNY].height,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      )
    );
  }

}