import 'package:actividad_05/screens/anime_detail.dart';
import 'package:actividad_05/screens/character_detail/character_detail.dart';
import 'package:actividad_05/screens/comic_detail/comic_detail.dart';
import 'package:actividad_05/screens/creator_detail/creator_detail.dart';
import 'package:actividad_05/screens/event_detail/event_detail.dart';
import 'package:actividad_05/screens/home/home_screen.dart';
import 'package:actividad_05/screens/home/paginated_creators_screen.dart';
import 'package:actividad_05/screens/home/paginated_events_screen.dart';
import 'package:actividad_05/screens/paginated_anime_all_time_screen.dart';
import 'package:actividad_05/screens/paginated_anime_popular_screen.dart';
import 'package:actividad_05/screens/paginated_anime_top_screen.dart';
import 'package:actividad_05/screens/paginated_anime_trending_screen.dart';
import 'package:actividad_05/screens/paginated_anime_upcoming_screen.dart';
import 'package:actividad_05/screens/serie_detail/serie_detail.dart';
import 'package:actividad_05/screens/home/paginated_comics_screen.dart';
import 'package:flutter/widgets.dart';

const Map<String, String> ROUTE_NAMES = {
  'HOME': 'Home',
  'CHARACTER_DETAIL': 'Character Details',
  'SERIE_DETAIL': 'Serie Details',
  'COMIC_DETAIL': 'Comic Details',
  'EVENT_DETAIL': 'Event Details',
  'CREATOR_DETAIL': 'Creator Details',
  'ANIME_DETAIL': 'Anime Details',
  // Estos están en minúsucula porque son iguales a las labels de las listas
  'Last comics': 'Last Comics',
  'Last events': 'Last Events',
  'New creators': 'New Creators',
  'Trending NOW': 'Trending NOW',
  'Popular this season': 'Popular this season',
  'Upcoming next season': 'Upcoming next season',
  'All time popular': 'All time popular',
  'Top': 'Top',
};

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  ROUTE_NAMES['HOME']: (BuildContext context) => HomeScreen(),
  ROUTE_NAMES['CHARACTER_DETAIL']: (BuildContext context) =>
      CharacterDetailScreen(),
  ROUTE_NAMES['SERIE_DETAIL']: (BuildContext context) => SerieDetailScreen(),
  ROUTE_NAMES['COMIC_DETAIL']: (BuildContext context) => ComicDetailScreen(),
  ROUTE_NAMES['EVENT_DETAIL']: (BuildContext context) => EventDetailScreen(),
  ROUTE_NAMES['CREATOR_DETAIL']: (BuildContext context) =>
      CreatorDetailScreen(),
  ROUTE_NAMES['ANIME_DETAIL']: (BuildContext context) => AniDetailScreen(),
  ROUTE_NAMES['Last comics']: (BuildContext context) => PaginatedComicsScreen(),
  ROUTE_NAMES['Last events']: (BuildContext context) => PaginatedEventsScreen(),
  ROUTE_NAMES['New creators']: (BuildContext context) => PaginatedCreatorsScreen(),
  ROUTE_NAMES['Trending NOW']: (BuildContext context) => PaginatedAnimeTrendingScreen(),
  ROUTE_NAMES['Popular this season']: (BuildContext context) => PaginatedAnimeSeasonScreen(),
  ROUTE_NAMES['Upcoming next season']: (BuildContext context) => PaginatedAnimeUpcomingScreen(),
  ROUTE_NAMES['All time popular']: (BuildContext context) => PaginatedAnimeAllTimeScreen(),
  ROUTE_NAMES['Top']: (BuildContext context) => PaginatedAnimeTopScreen(),
};
