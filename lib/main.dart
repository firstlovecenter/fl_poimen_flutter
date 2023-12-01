import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poimen/routes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/services/gql.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/color_scheme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(PoimenApp(
    currentVersion: currentVersion,
  ));
}

class PoimenApp extends StatelessWidget {
  const PoimenApp({Key? key, required this.currentVersion}) : super(key: key);

  final String currentVersion;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: ChangeNotifierProvider(
        create: (context) => SharedState(),
        child: MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'Poimen Flutter Client',
          theme: lightTheme,
          darkTheme: darkTheme,
          routes: appRoutes,
          home: LoginScreen(currentVersion: currentVersion),
        ),
      ),
    );
  }
}
