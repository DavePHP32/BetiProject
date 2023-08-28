import 'package:flutter/material.dart';
import 'package:untitled6/AboutStudioShine.dart';
import 'package:untitled6/helpUs.dart';
import 'BetibaApp.dart'; //
import 'settings.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';
import 'SongDetailsPage.dart';
import 'package:firebase_storage/firebase_storage.dart';


void main() async {

  // Initialisation de Flutter
  await FirebaseService.initFirebase(); // Appelez la méthode d'initialisation

  // Lancez votre application Flutter
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      initial: AdaptiveThemeMode.light, // Mode initial (clair par défaut)
      builder: (theme, darkTheme) =>
          MaterialApp(
            theme: theme, // Thème clair
            darkTheme: darkTheme, // Thème sombre
            home: HomePage(),
            routes: {
              '/parametres': (context) => ParametresPage(),
              '/aboutUs': (context) => AboutUsPage(),
              '/helpUs':(context)=>HelpUsPage(),
    '/songDetails': (context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return SongDetailsPage(
    songId: arguments?['songId'].toString() ?? '',
    songTitle: arguments?['songTitle'].toString() ?? '',
    songInterprete: arguments?['songInterprete'].toString() ?? '',
      songParoles: arguments?['songParoles'].toString() ?? '',
      songUrlAudio: arguments?['songUrl'].toString() ?? '',
      songProduction: arguments?['songProduction'].toString() ?? '', // Champ "Production"

    );
    },

            },
          ),
    );
  }
}

