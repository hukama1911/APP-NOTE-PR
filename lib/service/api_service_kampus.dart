import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/kampus.dart';
class ApiServiceKampus {
  static const String baseUrl = 'http://192.168.43.219:8000/api/kampus';

  static Future<List<Kampus>> getAllKampus() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        return jsonData.map((e) => Kampus.fromJson(e)).toList();
      } else if (jsonData is Map && jsonData.containsKey('data')) {
        return (jsonData['data'] as List).map((e) => Kampus.fromJson(e)).toList();
      }
    }
    throw Exception('Gagal memuat data');
  }

  static Future<bool> tambahKampus(Kampus kampus) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kampus.toJson()),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  static Future<bool> updateKampus(int id, Kampus kampus) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(kampus.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> hapusKampus(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }
}