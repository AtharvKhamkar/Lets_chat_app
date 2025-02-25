import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_chat/controller/location_controller.dart';
import 'package:lets_chat/repository/location_repository.dart';
import 'package:lets_chat/services/location_service.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';

class LocationShareScreen extends StatefulWidget {
  const LocationShareScreen({super.key});

  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  final LocationController controller = Get.put(LocationController());

  LocationService locationService = LocationService();
  final locationRepository = LocationRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.startLocationSharing();
    // locationService.startMonitoringLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Google Maps',
        actions: [
          IconButton(
              onPressed: () async {
                await locationRepository.startLocationSharing(
                    '670ae17b15ebeb0c34ffeb04',
                    '670ae17b15ebeb0c34ffeb04670ae4ba15ebeb0c34ffeb07',
                    131313.5,
                    121212.5);
              },
              icon: const Icon(Icons.plus_one))
        ],
      ),
      body: Obx(
        () {
          if (controller.currentLocation.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value!, zoom: 15),
            onMapCreated: controller.updateMapController,
            markers: controller.markers,
          );
        },
      ),
    );
  }
}
