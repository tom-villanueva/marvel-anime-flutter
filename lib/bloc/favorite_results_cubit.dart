import 'package:actividad_05/bloc/favorite_results_state.dart';
import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/services/shared_pref.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteResultsCubit extends Cubit<FavoriteResultsState> {
  FavoriteResultsCubit({@required this.marvelApiService})
      : super(FavoriteResultsIntialState()) {
          try {
           
          } catch (e) {
            print('Err $e');
          }          
      }

  final MarvelApiService marvelApiService;


  // Future<List<dynamic>> getEntities(List<dynamic> ids, Function request) async {
  //   List<dynamic> response = []; 
  //   for(var id in ids) {
  //     final res = await request(id);  
  //     response.add(res.data.results.first);
  //   }
  //   return response;
  // }

  Future<void> getAllEntitiesByIds() async {
    emit(FavoriteResultsFetchingState());
    try {
      SharedPref sharedPref = SharedPref();

      List<dynamic> characterFavorites = await sharedPref.read('favouriteCharacters');
      List<dynamic> comicFavorites = await sharedPref.read('favouriteComics');
      List<dynamic> eventFavorites = await sharedPref.read('favouriteEvents');
      List<dynamic> serieFavorites = await sharedPref.read('favouriteSeries');
      List<dynamic> creatorFavorites = await sharedPref.read('favouriteCreators');
      List<dynamic> animeFavorites = await sharedPref.read('favouriteAnimes');

      /**
       * Para cada map de sharedPref, 
       * se transforma a su tipo correspondiente
       */

      List<Character> characterResponse = []; 
      characterFavorites.forEach((element) {
        characterResponse.add(Character.fromJson(element));
      });
      List<Comic> comicResponse = [];
      comicFavorites.forEach((element) {
        comicResponse.add(Comic.fromJson(element));
      });
      List<MarvelEvent> eventResponse = [];
      eventFavorites.forEach((element) {
        eventResponse.add(MarvelEvent.fromJson(element));
      });
      List<Serie> serieResponse = [];
      serieFavorites.forEach((element) {
        serieResponse.add(Serie.fromJson(element));
      });
      List<Creator> creatorResponse = [];
      creatorFavorites.forEach((element) {
        creatorResponse.add(Creator.fromJson(element));
      });
      List<int> animeResponse = [];
      animeResponse = List<int>.from(animeFavorites);

      emit(FavoriteResultsSuccessState(
        characterFavorites: characterResponse,
        comicFavorites: comicResponse,
        eventFavorites: eventResponse,
        serieFavorites: serieResponse,
        creatorFavorites: creatorResponse,
        animeFavorites: animeResponse,
      ));

    } catch (e) {
      print('Err $e');
      emit(FavoriteResultsFailureState());
    }
  }
}