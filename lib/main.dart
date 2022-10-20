import 'package:flutter/material.dart';
import 'package:poimen/routes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/services/gql.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(const PoimenApp());
}

class PoimenApp extends StatelessWidget {
  const PoimenApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: ChangeNotifierProvider(
        create: (context) => SharedState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Poimen Flutter',
          theme: lightTheme,
          darkTheme: lightTheme,
          routes: appRoutes,
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
