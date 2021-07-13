import 'package:actividad_05/screens/home/widgets/entity_related_content.dart';
import 'package:actividad_05/services/shared_pref.dart';
import 'package:actividad_05/widgets/attribution.dart';
import 'package:actividad_05/widgets/detail_hero_with_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    getFavouriteCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final entity = ModalRoute.of(context).settings.arguments as dynamic;

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
                onPressed: () => print('Share'),
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
              Text(
                '⭐ ⭐ ⭐ ⭐ ⭐',
                style: TextStyle(fontSize: 25.0),
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
}