import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:poimen/routes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/login_screen.dart';
import 'package:poimen/services/gql.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  String minimumVersion = '1.2.14';

  int majorMinimumVersion = int.parse(minimumVersion.split('.')[0]);
  int minorMinimumVersion = int.parse(minimumVersion.split('.')[1]);
  int patchMinimumVersion = int.parse(minimumVersion.split('.')[2]);

  int majorCurrentVersion = int.parse(currentVersion.split('.')[0]);
  int minorCurrentVersion = int.parse(currentVersion.split('.')[1]);
  int patchCurrentVersion = int.parse(currentVersion.split('.')[2]);

  bool currentVersionNotValid(
      int majorMinimumVersion,
      int minorMinimumVersion,
      int patchMinimumVersion,
      int majorCurrentVersion,
      int minorCurrentVersion,
      int patchCurrentVersion) {
    if (majorCurrentVersion < majorMinimumVersion) {
      return false;
    } else if (minorCurrentVersion < minorMinimumVersion) {
      return false;
    } else if (patchCurrentVersion < patchMinimumVersion) {
      print('failed here');
      return false;
    } else {
      return true;
    }
  }

  if (!currentVersionNotValid(
    majorMinimumVersion,
    minorMinimumVersion,
    patchMinimumVersion,
    majorCurrentVersion,
    minorCurrentVersion,
    patchCurrentVersion,
  )) {
    runApp(
      MaterialApp(
        title: 'Poimen Flutter Client',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('App Version Too Low!'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(50.0)),
                const SizedBox(
                  height: 250,
                  child: RiveAnimation.asset('assets/animations/spinning_logo.riv'),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Please update your app to the latest version.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(16.0)),
                        Text(
                          'Current version: $currentVersion',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Minimum version: $minimumVersion',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  } else {
    // We're using HiveStore for persistence,
    // so we need to initialize Hive.
    await initHiveForFlutter();

    runApp(const PoimenApp());
  }
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
          // debugShowCheckedModeBanner: false,
          title: 'Poimen Flutter Client',
          theme: lightTheme,
          darkTheme: darkTheme,
          routes: appRoutes,
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
