import 'package:actividad_05/routes.dart';
import 'package:actividad_05/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await getDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Link.from([HttpLink('https://graphql.anilist.co')]),
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'MyComAni',
          theme: ThemeData(primaryColor: Colors.red),
          routes: routes,
          initialRoute: ROUTE_NAMES['HOME'],
        ));
  }
}
