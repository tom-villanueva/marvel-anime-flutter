import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/thumbnail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterHeroImplementation extends StatelessWidget {
  const CharacterHeroImplementation({Key key, this.character}): super(key: key);

  final Character character;

  //final Thumbnail thumb = Thumbnail.fromJson(character.thumbnail);

  @override
  Widget build(BuildContext context) {

    return Container(     
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
      height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black87.withOpacity(0.70),
          ),
        ]
      ),
      child: Stack(    
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ClipRRect(       
            child: Image.network(
              character.thumbnail.getSizedThumb(ThumbnailSize.LANDSCAPE_XLARGE),
              fit:BoxFit.cover,
              width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
              height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          Container(
            width: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].width,
            height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: <Color>[
                  Colors.black,
                  Colors.black12
                ]
              )
            ),
            child: 
              Text(
                character.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )
              ),
          )
        ]
      )
    );
  }
}