import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/services/location_service.dart';

class LocationController extends GetxController {
  final LocationService locationService = LocationService();
  final GetIt _getIt = GetIt.instance;
  late ChatService _chatService;

  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  RxSet<Marker> markers = <Marker>{}.obs;

  late GoogleMapController googleMapController;
  StreamSubscription<Position>? positionStram;

  @override
  void onInit() {
    _chatService = _getIt.get<ChatService>();
    super.onInit();
  }

  void startLocationSharing() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled =
          await locationService.geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await locationService.geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission =
            await locationService.geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.

      positionStram = locationService.geolocatorPlatform
          .getPositionStream()
          .listen((position) async {
        try {
          LatLng newLocation = LatLng(position.latitude, position.longitude);
          currentLocation.value = newLocation;

          markers.add(
            Marker(
                markerId: const MarkerId('live_location'),
                position: newLocation,
                icon: BitmapDescriptor.defaultMarker),
          );

          print(
              'updating pointer at ${position.latitude} and ${position.longitude}');

          print('changed location');

          await _chatService.shareLocationSharingEvent(
              '670ae17b15ebeb0c34ffeb04670ae4ba15ebeb0c34ffeb07',
              '670ae17b15ebeb0c34ffeb04',
              position.latitude,
              position.longitude);
        } catch (e) {
          print(
              'Error caught in the getPositionStream listen :: location_controller :: ${e.toString()}');
        }
      });
    } catch (e) {
      debugPrint(
          'Error caught in startLocationSharing :: location_controller :: ${e.toString()}');
    }
  }

  void updateMapController(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    positionStram?.cancel();
    super.dispose();
  }
}

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(
      () => LocationController(),
      fenix: true,
    );
  }
}
