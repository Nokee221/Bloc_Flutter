import 'package:flutter/material.dart';

import 'pages/covid_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Covid List",
      debugShowCheckedModeBanner: false,
      home: CovidPage(),
    );
  }
}