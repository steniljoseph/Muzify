import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/database/dbsongs.dart';
import 'package:music/screens/getstarted.dart';
import 'package:music/screens/splash.dart';
import 'package:music/themeprovider.dart';
import 'screens/home.dart';
import 'screens/nowplaying.dart';

ThemeMode m = ThemeMode.system;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = MusicBox.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: m,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      title: 'Music',
      home: const SplashScreen(),
    );
  }
}
