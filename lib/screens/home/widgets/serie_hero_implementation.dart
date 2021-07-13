
import 'package:actividad_05/models/thumbnail.dart';
import 'package:flutter/cupertino.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:flutter/material.dart';

class SerieHeroImplementation extends StatelessWidget {
  const SerieHeroImplementation({Key key, this.serie}): super(key: key);

  final Serie serie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].width,
      height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].height,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 8,
          color: Colors.red.shade800,
        )]
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: Image.network(
                serie.thumbnail.getSizedThumb(ThumbnailSize.LANDSCAPE_SMALL),
                fit:BoxFit.cover,
                width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
                height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
              ),
            ), 
          ),        
          Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].width,
            height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_SMALL].height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Colors.red.shade400,
                  Colors.red.shade800.withOpacity(0.90),
                ]
              )
            ),
            child: Text(
              serie.title,
              //textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
            )
          ),
        ],
      )
    );
  }

}