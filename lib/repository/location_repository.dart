import 'package:flutter/material.dart';
import 'package:lets_chat/constants/constants.dart';
import 'package:lets_chat/modals/api_response_model.dart';
import 'package:lets_chat/modals/location_room_details_model.dart';
import 'package:lets_chat/modals/nearby_places_model.dart';
import 'package:lets_chat/services/api_client_service.dart';

class LocationRepository {
  final apiClient = ApiClientService();

  Future<LocationRoomDetailsModel?> startLocationSharing(
      String userId, String roomId, double latitude, double longitude) async {
    try {
      Map<String, dynamic> headers = {'x-user-id': userId};

      Map<String, dynamic> body = {
        'latitude': latitude,
        'longitude': longitude
      };

      final response = await apiClient.post('tracking/start/$roomId',
          body: body, headers: headers);
      debugPrint('Response of the startLocationSharing endpoint is $response');

      //Need to handle null check operation if the response is null
      final locationRoomDetails = response['response'];
      return LocationRoomDetailsModel.fromJson(locationRoomDetails);
    } catch (e) {
      debugPrint(
          'Error caught in the startLocationSharing :: location_repository :: ${e.toString()}');
    }
    return null;
  }

  Future<List<NearbyPlacesModel>> getNearByLocations(
      {required double latitude,
      required double longitude,
      int? radius = 1500}) async {
    try {
      Map<String, dynamic> queryParameters = {
        'location': '$latitude,$longitude',
        'radius': radius,
        'key': Constants.kGoogleMapsApiKey
      };
      final response = await apiClient
          .chooseApiClient(useGoogleMaps: true)
          .get('/place/nearbysearch/json', queryParameters: queryParameters);

      final locationsList = await response.data['results'];

      print('nearby locations result before parsing is $locationsList');

      if (locationsList != null && locationsList is List) {
        return locationsList
            .map((location) => NearbyPlacesModel.fromJson(location))
            .toList();
      }
    } catch (e) {
      debugPrint(
          'Error caught in the getNearByLocations :: location_repository :: ${e.toString()}');
    }
    return [];
  }
}
