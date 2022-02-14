import 'package:actividad_05/models/marvel_event.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/thumb_hero.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedEventsScreen extends StatefulWidget {
  @override
  _PaginatedEventsScreenState createState() => _PaginatedEventsScreenState();
}

class _PaginatedEventsScreenState extends State<PaginatedEventsScreen> {
  static const _pageSize = 20;

  final PagingController<int, MarvelEvent> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      MarvelResponse<MarvelEvent> newComics = await MarvelApiService().getPaginatedEvents(pageKey);
      final newItems = newComics.data.results;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) { 
      return Scaffold(
        body:Column(
         children:<Widget>[
          Row(
            children: [
              IconButton(
                onPressed: () => {Navigator.of(context).pop()},
                icon: Icon(Icons.arrow_back),
                iconSize: 35.0,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(left: 75),
                child: Text('Last events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
              ),
            ],
          ),
          Expanded(
            child: PagedListView<int, MarvelEvent>(
              scrollDirection: Axis.vertical,
              pagingController: _pagingController,
              padding: EdgeInsets.only(left: 20, right: 20),
              builderDelegate: PagedChildBuilderDelegate<MarvelEvent>(
                itemBuilder: (context, item, index) => GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ROUTE_NAMES['EVENT_DETAIL'], arguments: item),
                      child: ThumbHero(thumb: item.thumbnail)
                ),
              )
            ), 
          )
        ],
        )
      );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}