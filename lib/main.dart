import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poimen/handle_login.dart';
import 'package:poimen/helpers/shared_pref.dart';
import 'package:poimen/routes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/services/gql.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:poimen/state/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await initHiveForFlutter();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SharedState()),
        ChangeNotifierProvider(create: (_) => AuthState()),
      ],
      child: PoimenApp(currentVersion: currentVersion),
    ),
  );
}

class PoimenApp extends StatelessWidget {
  const PoimenApp({Key? key, required this.currentVersion}) : super(key: key);

  final String currentVersion;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: '🐑 Poimen',
        theme: newLightTheme,
        darkTheme: newDarkTheme,
        routes: appRoutes,
        initialRoute: "/",
        home: HandleLogin(
          currentVersion: currentVersion,
        ),
      ),
    );
  }
}

/*LoginScreen(currentVersion: currentVersion)

GraphQLProvider(
     
      child: MultiProvider(
        providers: [
      
        ],
        child: MaterialApp(
title: '🐑 Poimen',
          theme: newLightTheme,
          darkTheme: newDarkTheme,
          routes: appRoutes,
          home: const HandleLogin(),
        ),
      ),
    );
*/
