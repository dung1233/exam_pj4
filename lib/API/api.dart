import 'dart:convert';
import 'package:exam/model/place.dart';
import 'package:http/http.dart' as http;

Future<List<Place>> fetchPlaces() async {
  final response = await http.get(Uri.parse(
      'https://67f7456542d6c71cca6488af.mockapi.io/api/allplace/places'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Place.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load places');
  }
}
