import 'dart:async';

import 'package:actividad_05/bloc/search_results_state.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  SearchResultsCubit({@required this.marvelApiService})
      : super(SearchResultsIntialState());

  final MarvelApiService marvelApiService;

  Future<void> searchCharactersByName(String nameStartsWith) async {
    emit(SearchResultsFetchingState());
    try {
      final response = await MarvelApiService().getAllCharacters(queryParams: {
        "orderBy": "-modified",
        "nameStartsWith": nameStartsWith
      });
      print(response);
      if (response.data.results.isEmpty) {
        emit(SearchResultsEmptyState());  
        }
      else {
        emit(SearchResultsSuccessState(characterResults: response.data.results));
      }
    } catch (_) {
      emit(SearchResultsFailureState());
    }
  }
}
