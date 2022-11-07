import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pantry_management/supermarket/directions.dart';
import 'package:http/http.dart' as http;

class DirectionsRepository {

  Future<Directions> getDirections(placeId, position, api_key) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?&destination=place_id:' +
            placeId +
            '&mode=driving&origin=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&key=' +
            api_key);

    final response = await http.get(url);

    // Check if response is successful
    if (response.statusCode == 200) {
     //Map<String, dynamic> directions = jsonDecode(response.body);
      return Directions.fromMap(jsonDecode(response.body));
    }
    return Directions.fromMap(jsonDecode(response.body));
  }
}
