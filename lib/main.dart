import 'package:awesome_quotes_exercise/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // TODO passar a usar o MultiProvider para injetar um FavoritesModel e um QuotesService
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome quotes',
      theme: themeLight(),
      home: Placeholder(),
    );
  }
}

