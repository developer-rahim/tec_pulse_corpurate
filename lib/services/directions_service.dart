import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tacpulse/models/directions.dart';
// import 'package:tacpulse/.env.dart';

class DirectionsService {
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  late final Dio _dio;

  DirectionsService({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        // 'key': googleMapsAPIKey,
        'key': "AIzaSyCFQGsCk-tIRIcLPYFcOkgrxzE1jW8h4OE",
      },
    );
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      throw Exception('Could not load Directions data');
    }
  }
}
