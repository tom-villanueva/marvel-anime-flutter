import 'package:actividad_05/models/thumbnail.dart';
import 'package:flutter/material.dart';

class DetailHeroWithBackBtnImplementation extends StatelessWidget {
  const DetailHeroWithBackBtnImplementation({
    Key key,
    @required this.thumbnail,
  }) : super(key: key);

  final Thumbnail thumbnail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: thumbnailSizeDimensions[ThumbnailSize.LANDSCAPE_XLARGE].height,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          offset: Offset(0,4),
          blurRadius: 10,
          color: Colors.black87
        )],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: <Color>[
            Colors.black45,
            Colors.black38.withAlpha(0),
          ]
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(60, 40), 
          bottomRight: Radius.elliptical(60, 40)
        ),
        image: DecorationImage(
          image: NetworkImage(thumbnail.getSizedThumb(ThumbnailSize.LANDSCAPE_XLARGE)),
          fit: BoxFit.cover,
        )
      ),    
      child: Stack(children: [
      Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: IconButton(
            icon: Icon(Icons.arrow_back, 
              color: Colors.white,
              size: 30
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
      ],),        
    );
  }
}