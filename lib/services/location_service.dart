import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  late StreamSubscription<ServiceStatus> serviceStatusStream;
  Timer? permissionChecker;

  Future<bool> checkLocationPermissions() async {
    try {
      bool serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        bool userEnabled = await showLocationServiceDialog();
        if (!userEnabled) return false;
      }

      LocationPermission permission =
          await geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return await showHandlePermissionDialog();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return await showPermissionDeniedForeverDialog();
      }

      return true;
    } catch (e) {
      debugPrint(
          'Error while requesting location permission :: checkLocationPermission :: ${e.toString()}');
    }
    return false;
  }

  //For future use to enable constantly checking location is enabled or not
  void startMonitoringLocationPermission() {
    serviceStatusStream = geolocatorPlatform
        .getServiceStatusStream()
        .listen((ServiceStatus status) async {
      if (status == ServiceStatus.disabled) {
        bool userEnabled = await showLocationServiceDialog();
        if (!userEnabled) {
          stopMonitoringLocationPermission();
        }
      }
    });

    permissionChecker =
        Timer.periodic(const Duration(seconds: 5), (timer) async {
      LocationPermission permission =
          await geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        bool granted = await showHandlePermissionDialog();
        if (!granted) {
          stopMonitoringLocationPermission();
        }
      }
    });
  }

  void stopMonitoringLocationPermission() {
    serviceStatusStream.cancel();
    permissionChecker?.cancel();
  }

  Future<bool> showLocationServiceDialog() async {
    return await Get.defaultDialog<bool>(
            title: 'Location Required',
            middleText:
                'This feature requires location permission. Please enable location permission',
            textConfirm: 'Enable',
            textCancel: 'Cancel',
            onConfirm: () async {
              await geolocatorPlatform.openLocationSettings();
              Get.back(result: true);
            },
            onCancel: () => Get.back(result: false)) ??
        false;
  }

  Future<bool> showHandlePermissionDialog() async {
    return await Get.defaultDialog<bool>(
            title: 'Permission Needed',
            middleText:
                'Location access is required to continue. Grant permission?',
            textConfirm: 'Grant',
            textCancel: 'Cancel',
            onConfirm: () async {
              await geolocatorPlatform.openLocationSettings();
              Get.back(result: true);
            },
            onCancel: () => Get.back(result: false)) ??
        false;
  }

  Future<bool> showPermissionDeniedForeverDialog() async {
    return await Get.defaultDialog<bool>(
            title: 'Permission Denied',
            middleText:
                'You have permanently denied location access. Enable it from settings.',
            textConfirm: 'Open Settings',
            textCancel: 'Cancel',
            onConfirm: () async {
              await geolocatorPlatform.openLocationSettings();
              Get.back(result: true);
            },
            onCancel: () => Get.back(result: false)) ??
        false;
  }
}
