import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/cat_breed.dart';

class CatApiDatasource {
  static const String _baseUrl = 'https://api.thecatapi.com/v1/breeds';
  static const String _apiKey = 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWky W2nr ';

  Future<List<CatBreed>> fetchBreeds({int page = 0, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?api_key=$_apiKey&limit=$limit&page=$page'),
      headers: {'x-api-key': _apiKey},
    );
  if (response.statusCode == 200) {
    final List data = json.decode(response.body);
    List<CatBreed> breeds = [];
    for (var e in data) {
      final breed = CatBreed.fromJson(e);
      if (breed.referenceImageId != null) {
        breed.imageUrl = await fetchImageUrl(breed.referenceImageId!);
      }
      breeds.add(breed);
    }
    return breeds;
  } else {
    throw Exception('Error al obtener razas');
  }
}
  Future<String?> fetchImageUrl(String referenceImageId) async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/$referenceImageId'),
      headers: {'x-api-key': _apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['url'] as String?;
    }
    return null;
  }
  Future<List<CatBreed>> searchBreeds(String query) async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds/search?q=$query&attach_image=1'),
      headers: {
        'x-api-key': _apiKey, // Si tu endpoint requiere API key
      },
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      List<CatBreed> breeds = [];
      for (var e in data) {
        final breed = CatBreed.fromJson(e);
        if (breed.referenceImageId != null) {
          breed.imageUrl = await fetchImageUrl(breed.referenceImageId!);
        }
        breeds.add(breed);
      }
      return breeds;
    } else {
      throw Exception('Error al buscar razas');
    }
  }
}