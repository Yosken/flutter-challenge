import 'dart:convert';
import 'package:yosken_challenge1/secret/key.dart' as key;
import 'package:http/http.dart' as http;
import 'package:yosken_challenge1/src/chargespots.dart';
import 'package:yosken_challenge1/constant/importer_constant.dart';

Future<ChargerSpots> fetchChargerSpots(SwAndNeLatLng swAndNeLatLng) async {
  final queryParameters = {
    'sw_lat': swAndNeLatLng.swLat.toString(),
    'sw_lng': swAndNeLatLng.swLng.toString(),
    'ne_lat': swAndNeLatLng.neLat.toString(),
    'ne_lng': swAndNeLatLng.neLng.toString(),
    'fields': apiFields.join(',')
  };
  final uri = Uri.https(uriHost, uriPath, queryParameters);
  final response = await http.get(uri, headers: {
    'accept': uriHeaderAccept,
    'X-EVENE-NATIVE-API-TOKEN': key.token
  });
  if (response.statusCode == 200) {
    return ChargerSpots.fromJson(json.decode(response.body));
  } else {
    throw Exception('Can\'t get users');
  }
}