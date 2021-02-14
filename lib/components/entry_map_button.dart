import 'package:flutter/material.dart';
import 'package:flutter_google_maps/provider/location_provider.dart';
import 'package:flutter_google_maps/ui/maps.dart';
import 'package:provider/provider.dart';

class EntryToMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocationProvider>(context, listen: true);
    return RaisedButton(
      onPressed: () {
        provider.getLocation();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Maps()));
      },
      child: Container(
        child: Text("Enter to Map"),
      ),
    );
  }
}
