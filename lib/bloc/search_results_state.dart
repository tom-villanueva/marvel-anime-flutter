import 'package:actividad_05/models/character.dart';
import 'package:equatable/equatable.dart';

abstract class SearchResultsState extends Equatable {
  List<Character> characterResults;

  @override
  List<Object> get props => [];
}

class SearchResultsIntialState extends SearchResultsState {}

class SearchResultsEmptyState extends SearchResultsState {}

class SearchResultsFetchingState extends SearchResultsState {}

class SearchResultsFailureState extends SearchResultsState {}

class SearchResultsSuccessState extends SearchResultsState {
  SearchResultsSuccessState({this.characterResults});

  final List<Character> characterResults;

  @override
  List<Object> get props => [characterResults];
}
