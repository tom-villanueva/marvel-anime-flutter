import 'dart:async';

import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/screens/home/widgets/entity_related_content.dart';
import 'package:actividad_05/services/shared_pref.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EntityDetailScreen extends StatefulWidget {
  const EntityDetailScreen(
    {Key key, 
    this.entity, 
    this.sharedKey,
    this.name,
    this.description,
    this.type
    }) : super(key: key);

  final dynamic entity;
  final String sharedKey;
  final String name;
  final String description;
  final Type type;
 
  @override
  _EntityDetailScreenState createState() => _EntityDetailScreenState();
}

class _EntityDetailScreenState extends State<EntityDetailScreen> {
  SharedPref sharedPref = SharedPref();
  List<dynamic> favoritedEntities = [];
  bool favorited = false;
  double starsRating = 0.0;

  final database = FirebaseDatabase.instance.ref();
  StreamSubscription _starsRatingStream;

  getEntityPath() {
    int widgetId = widget.entity.id;

    if (widget.type == Character) {
      return '/characters/$widgetId/stars';
    } else if (widget.type == Serie) {
      return '/series/$widgetId/stars';
    } else if (widget.type == Comic) {
      return '/comics/$widgetId/stars';
    } else if (widget.type == MarvelEvent) {
      return '/events/$widgetId/stars';
    } else if (widget.type == Creator) {
      return '/creators/$widgetId/stars';
    }
  }

  void _activateListeners() {
    _starsRatingStream = 
    database.child(getEntityPath()).onValue.listen((event) {
      setState(() {
        starsRating = (event.snapshot.value as num).toDouble();
            });
    });
  }

  toggleFavourite(dynamic entity) => () async {
    setState(() {
      if (favoritedEntities.contains(widget.entity.id)) {
        favoritedEntities.remove(entity.id);
      } else {
        favoritedEntities.add(entity.id);
      }
    });
    try {
      List<dynamic> favoriteEntities = await sharedPref.read(widget.sharedKey);

      /**
       * Busco el elemento en la sharedPref
       * si no lo encuentra, entonces devuelve null
       */
      if (favoriteEntities.firstWhere(
        (e) => e['id'] == widget.entity.id, orElse: () => null) != null) {

        /*-- remuevo --*/
        favoriteEntities.removeWhere((e) => e['id'] == widget.entity.id);
      } else {      

        /*-- agrego --*/
        favoriteEntities.add(entity);
      }
      sharedPref.save(widget.sharedKey, favoriteEntities);
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }
  };

  getFavouriteCharacters() async {
    try {
      List<dynamic> favoriteEntities = await sharedPref.read(widget.sharedKey);

      setState(() {
        favoriteEntities.forEach((element) {
          favoritedEntities.add(element['id']);
        });
      });
    } catch (e) {
      print('Err $e');
      SharedPreferences.setMockInitialValues({});
    }  
  }

  getOrCreateStarsRating() async {
    DatabaseReference ref = database.child(getEntityPath());

    DatabaseEvent event = await ref.once();

    print('value: ');
    print(event.snapshot.value);

    if(event.snapshot.value == null) {
      ref.set(0.0);//{'stars': 0.0});
      setState(() {
      starsRating = 0.0;
            });
    } 
    /*else {
      setState(() {
      starsRating = (event.snapshot.value as num).toDouble();
            });
    }*/
    _activateListeners();

    print('rating: ' + starsRating.toString());

  }

  @override
  void initState() {
    super.initState();
    getFavouriteCharacters();
    getOrCreateStarsRating();
  }

  @override
  Widget build(BuildContext context) {
    final entity = ModalRoute.of(context).settings.arguments as dynamic;
    final starsRef = database.child(getEntityPath());

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          DetailHeroWithBackBtn(thumbnail: entity.thumbnail),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed:
                    toggleFavourite(entity),
                icon: (favoritedEntities.contains(widget.entity.id))
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline),
                iconSize: 40.0,
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  String entityName = widget.name;
                  Share.share(
                    "Checkout $entityName",
                  );
                },
                icon: Icon(Icons.share),
                iconSize: 35.0,
                color: Colors.black,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.0),
              RatingBar.builder(
                initialRating: starsRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                glow: true,
                glowRadius: 5,
                glowColor: Colors.amber,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  starsRef.set(rating);
                },
              ),
              SizedBox(height: 15.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                height: 120.0,
                child: SingleChildScrollView(
                  child: Text(
                    widget.description == null ? '' : widget.description,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'RELATED CONTENT',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          EntityRelatedContent(
            entity: entity,
            type: widget.type,
          ),
          Attribution(),
        ],
      ),
    );
  }

  @override
    void deactivate() {
      _starsRatingStream.cancel();
      super.deactivate();
    }

}