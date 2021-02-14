import 'package:flutter/material.dart';
import 'package:flutter_google_maps/components/entry_map_button.dart';
import 'package:flutter_google_maps/provider/location_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Google Maps Sample"),
        ),
        body: Center(child: EntryToMap()),
      ),
    );
  }
}
