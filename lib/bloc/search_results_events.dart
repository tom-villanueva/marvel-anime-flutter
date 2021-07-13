import 'package:equatable/equatable.dart';

abstract class SearchResultsEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchResultsInputEntered extends SearchResultsEvents {
  SearchResultsInputEntered({this.searchText});
  final String searchText;

  @override
  List<Object> get props => [searchText];
}
