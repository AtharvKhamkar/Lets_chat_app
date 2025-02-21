import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_chat/services/location_service.dart';

class LocationController extends GetxController {
  final LocationService locationService = LocationService();

  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  RxSet<Marker> markers = <Marker>{}.obs;

  late GoogleMapController googleMapController;
  StreamSubscription<Position>? positionStram;

  void startLocationSharing() async {
    try {
      positionStram = locationService.geolocatorPlatform
          .getPositionStream()
          .listen((position) {
        LatLng newLocation = LatLng(position.latitude, position.longitude);
        currentLocation.value = newLocation;

        markers.add(
          Marker(
              markerId: const MarkerId('live_location'),
              position: newLocation,
              icon: BitmapDescriptor.defaultMarker),
        );

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
