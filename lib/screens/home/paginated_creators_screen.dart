import 'package:actividad_05/models/creator.dart';
import 'package:actividad_05/models/marvel_response.dart';
import 'package:actividad_05/routes.dart';
import 'package:actividad_05/services/marvel_api_service.dart';
import 'package:actividad_05/widgets/thumb_hero.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedCreatorsScreen extends StatefulWidget {
  @override
  _PaginatedCreatorsScreenState createState() => _PaginatedCreatorsScreenState();
}

class _PaginatedCreatorsScreenState extends State<PaginatedCreatorsScreen> {
  static const _pageSize = 20;

  final PagingController<int, Creator> _pagingController =
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
      MarvelResponse<Creator> newComics = await MarvelApiService().getPaginatedCreators(pageKey);
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
                child: Text('New creators', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
              ),
            ],
          ),
          Expanded(
            
            child: PagedListView<int, Creator>(
              scrollDirection: Axis.vertical,
              pagingController: _pagingController,
              padding: EdgeInsets.only(left: 20, right: 20),
              builderDelegate: PagedChildBuilderDelegate<Creator>(
                itemBuilder: (context, item, index) => GestureDetector(
                      onTap: () => Navigator.pushNamed(context, ROUTE_NAMES['CREATOR_DETAIL'], arguments: item),
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