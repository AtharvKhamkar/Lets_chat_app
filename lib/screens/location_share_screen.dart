import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_chat/controller/location_controller.dart';
import 'package:lets_chat/repository/location_repository.dart';
import 'package:lets_chat/services/app_dialog_handler_service.dart';
import 'package:lets_chat/services/location_service.dart';
import 'package:lets_chat/utils/colors.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';

class LocationShareScreen extends StatefulWidget {
  const LocationShareScreen({super.key});

  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  final LocationController locationController = Get.put(LocationController());

  LocationService locationService = LocationService();
  final locationRepository = LocationRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController.startLocationSharing();
    // locationService.startMonitoringLocationPermission();
    locationController.storeNearByPlaces(
        latitude: 37.3326595, longitude: -122.0091283);
    Future.delayed(
      const Duration(seconds: 5),
      () {
        AppDialogHandlerService.showNearByPlacesBottomSheet(
            context, locationController.nearByPlacesList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Google Maps',
        actions: [
          IconButton(
              onPressed: () async {
                await locationRepository.getNearByLocations(
                    latitude: 37.3326595, longitude: -122.0091283);
              },
              icon: const Icon(Icons.plus_one))
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () {
                if (locationController.currentLocation.value == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: locationController.currentLocation.value!,
                      zoom: 15),
                  onMapCreated: locationController.updateMapController,
                  markers: locationController.markers,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(-40, 0),
        child: FloatingActionButton.extended(
          isExtended: true,
          backgroundColor: AppColors.secondaryTextColor,
          onPressed: () {
            AppDialogHandlerService.showNearByPlacesBottomSheet(
                context, locationController.nearByPlacesList);
          },
          label: Text(
            'Nearby Places',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
