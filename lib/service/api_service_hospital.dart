import 'dart:convert';
import 'package:crud_rumah_sakit/model/hospital.dart';
import 'package:http/http.dart' as http;

class ApiServiceHospital {
  static const String baseUrl = 'http://192.168.43.219:8000/api/hospital';

  Future<List<Hospital>> getHospitals() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Jika response memiliki wrapper seperti {"status": "success", "data": [...]}
        if (jsonData is Map && jsonData.containsKey('data')) {
          List data = jsonData['data'];
          return data.map((e) => Hospital.fromJson(e)).toList();
        }
        // Jika response langsung array
        else if (jsonData is List) {
          return jsonData.map((e) => Hospital.fromJson(e)).toList();
        } else {
          throw Exception('Format response tidak sesuai');
        }
      } else {
        throw Exception('Gagal memuat data rumah sakit: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Gagal memuat data rumah sakit: $e');
    }
  }

  Future<bool> addHospital(Hospital hospital) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(hospital.toJson()),
      );

      print('Add response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error adding hospital: $e');
      return false;
    }
  }

  Future<bool> updateHospital(int id, Hospital hospital) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(hospital.toJson()),
      );

      print('Update response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating hospital: $e');
      return false;
    }
  }

  Future<bool> deleteHospital(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      print('Delete response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting hospital: $e');
      return false;
    }
  }
}