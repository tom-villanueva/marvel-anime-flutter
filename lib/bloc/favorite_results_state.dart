import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/models/comic.dart';
import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/serie.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteResultsState extends Equatable {
  List<Character> characterFavorites;
  List<Serie> serieFavorites;
  List<Comic> comicFavorites;
  List<MarvelEvent> eventFavorites;
  List<Creator> creatorFavorites;
  List<int> animeFavorites;

  @override
  List<Object> get props => [];
}

class FavoriteResultsIntialState extends FavoriteResultsState {
  @override
  List<Object> get props => [];
}

class FavoriteResultsFetchingState extends FavoriteResultsState {
  @override
  List<Object> get props => [];
}

class FavoriteResultsFailureState extends FavoriteResultsState {
  @override
  List<Object> get props => [];
}

class FavoriteResultsSuccessState extends FavoriteResultsState {
  FavoriteResultsSuccessState({
    this.characterFavorites, 
    this.serieFavorites,
    this.comicFavorites,
    this.eventFavorites,
    this.creatorFavorites,
    this.animeFavorites,
    });

  final List<Character> characterFavorites;
  final List<Serie> serieFavorites;
  final List<Comic> comicFavorites;
  final List<MarvelEvent> eventFavorites;
  final List<Creator> creatorFavorites;
  final List<int> animeFavorites;

  @override
  List<Object> get props => [
    characterFavorites,
    serieFavorites,
    comicFavorites,
    eventFavorites,
    creatorFavorites,
    animeFavorites
  ];
}