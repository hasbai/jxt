import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'consts.dart';

_handleLocationPermission() async {
  var serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied.');
  }
}

Future<Position> getLocation() async {
  try{
    await _handleLocationPermission();
    // var position = await Geolocator.getLastKnownPosition();
    // if (position != null) {
    //   Geolocator.getCurrentPosition();
    //   return position;
    // }
    return await Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 10),
    );
  } catch (e) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () {
            Geolocator.openAppSettings();
          },
        )
      )
    );
    rethrow;
  }
}