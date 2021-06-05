import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sale.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/sale_screen.dart';
import 'package:flutter_app/shared/loader.dart';
import 'package:flutter_app/utils/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setup();
  setUrlStrategy(PathUrlStrategy());
  return runApp(App());
}

class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => App();
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Brightness brightness = Brightness.light;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.assistantTextTheme(
      TextTheme(
        headline3: TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.08,
        ),
        headline4: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        headline5: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
        ),
        bodyText2: TextStyle(
          fontSize: 13,
          color: Color(0xff52555c),
        ),
      ),
    );
    final materialTheme = new ThemeData(
      primaryColor: Color(0xff333333),
      textTheme: textTheme,
    );
    final materialDarkTheme = new ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0xff333333),
      textTheme: textTheme,
    );

    final cupertinoTheme = new CupertinoThemeData(
      brightness: brightness,
      primaryColor: CupertinoDynamicColor.withBrightness(
        color: Colors.white,
        darkColor: Colors.yellow,
      ),
      barBackgroundColor: Color(0xff333333),
      textTheme: CupertinoTextThemeData(primaryColor: Colors.white),
    );

    // Example of optionally setting the platform upfront.
    //final initialPlatform = TargetPlatform.iOS;

    // If you mix material and cupertino widgets together then you cam
    // set this setting. Will mean ios dark mode to not to work properly
    //final settings = PlatformSettingsData(iosUsesMaterialWidgets: true);

    // This theme is required since icons light/dark mode will look for it
    return Theme(
      data: brightness == Brightness.light ? materialTheme : materialDarkTheme,
      child: PlatformProvider(
        //initialPlatform: initialPlatform,
        // settings: PlatformSettingsData(
        //   platformStyle: PlatformStyleData(
        //     web: PlatformStyle.Cupertino,
        //   ),
        // ),
        builder: (context) => FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Center(child: Text("Error"));
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return PlatformApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                title: 'HackIDC65',
                material: (_, __) {
                  return new MaterialAppData(
                    theme: materialTheme,
                    darkTheme: materialDarkTheme,
                    themeMode: brightness == Brightness.light
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
                },
                cupertino: (_, __) => new CupertinoAppData(
                  theme: cupertinoTheme,
                ),
                // home: LandingPage(() {
                //   setState(() {
                //     brightness = brightness == Brightness.light
                //         ? Brightness.dark
                //         : Brightness.light;
                //   });
                // }),
                initialRoute: '/',
                routes: {
                  // When navigating to the "/" route, build the FirstScreen widget.
                  '/': (context) => HomeScreen(),
                },
                onGenerateRoute: (settings) {
                  if (settings.name?.startsWith("/sale") == true) {
                    final args = settings.arguments;

                    // Then, extract the required data from the arguments and
                    // pass the data to the correct screen.
                    return platformPageRoute(
                        builder: (context) {
                      return SaleScreen.id(settings.name!.substring(min("/sale/".length, settings.name!.length)));
                    }, context: context);
                  }
                },
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Loader();
          },
        ),
      ),
    );
  }
}
