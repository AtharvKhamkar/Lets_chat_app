import 'package:flutter/material.dart';
import 'package:lets_chat/modals/api_response_model.dart';
import 'package:lets_chat/modals/location_room_details_model.dart';
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
}
