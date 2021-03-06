import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'models/vehicules_list_data.dart';
import 'services/camera_service.dart';
import 'ui/router.dart';

// TODO - Import / Export : Google Drive / Local / Dropbox / BdzConso Web
// TODO - BloCs => Provider
// TODO - Étape ultime : utiliser la caméra pour remplir automatiquement les valeurs d'un plein (ML de Google Firebase ?)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_FR';
  await CameraService.initialize();
  await Permission.camera.request();
  runApp(
    ChangeNotifierProvider<VehiculeListData>(
      create: (_) => VehiculeListData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fueltter',
      theme: ThemeData.dark().copyWith(
        backgroundColor: Color(0xFF212121),
        scaffoldBackgroundColor: Color(0xFF212121),
        accentColor: Color(0xFFbbe1fa),
        primaryColor: Color(0xFF0f4c75),
        buttonColor: Color(0x803282b8),
        cardColor: Color(0x800f4c75),
        bottomSheetTheme: ThemeData.dark().bottomSheetTheme.copyWith(
              backgroundColor: Color(0xFF212121),
            ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF4978a4),
            foregroundColor: Color(0xFF1b262c)),
      ),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'),
      ],
      initialRoute: HomeRoute,
      onGenerateRoute: generateRoute,
    );
  }
}
