import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'consts.dart';

_handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
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
  }
  return await Geolocator.getCurrentPosition();
}