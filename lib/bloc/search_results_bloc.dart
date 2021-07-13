import 'dart:async';

import 'package:actividad_05/bloc/search_results_events.dart';
import 'package:actividad_05/bloc/search_results_state.dart';
import 'package:actividad_05/models/character.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SearchResultsBloc extends Bloc<SearchResultsEvents, SearchResultsState> {
  SearchResultsBloc({@required this.marvelApiService})
      : super(SearchResultsIntialState());

  final MarvelApiService marvelApiService;

  @override
  Stream<SearchResultsState> mapEventToState(SearchResultsEvents event) async* {
    if (event is SearchResultsInputEntered) {
      try {
        final characters = await _searchCharactersByName(event.searchText);
        yield SearchResultsSuccessState(characterResults: characters);
        return;
      } catch (_) {
        yield SearchResultsFailureState();
      }
    }
  }

  Future<List<Character>> _searchCharactersByName(nameStartsWith) async {
    final response = await MarvelApiService().getAllCharacters(queryParams: {
      "orderBy": "-modified",
      "nameStartsWith": nameStartsWith
    });
    return response.data.results;
  }
}
