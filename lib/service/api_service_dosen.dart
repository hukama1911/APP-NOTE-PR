import 'dart:convert';

import 'package:crud_rumah_sakit/model/dosen.dart';
import 'package:http/http.dart' as http;

class ApiServiceDosen {
  static const String baseUrl = 'http://192.168.43.219:8000/api/dosen';
  Future<List<Dosen>> getDosens() async {
    final response = await http.get(Uri.parse(baseUrl));

    print('GET STATUS: ${response.statusCode}');
    print('RESPONSE BODY: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((dosen) => Dosen.fromJson(dosen)).toList();
    } else {
      throw Exception('Gagal mengambil data dosen. Status: ${response.statusCode}');
    }
  }

  Future<bool> addDosen(Dosen dosen) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: dosen.toJson(),
    );

    print('POST STATUS: ${response.statusCode}');
    print('POST RESPONSE: ${response.body}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<bool> updateDosen(int no, Dosen dosen) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$no'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: dosen.toJson(),
    );

    print('PUT STATUS: ${response.statusCode}');
    print('PUT RESPONSE: ${response.body}');

    return response.statusCode == 200;
  }

  Future<bool> deleteDosen(int no) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$no'),
      headers: {
        'Accept': 'application/json',
      },
    );

    print('DELETE STATUS: ${response.statusCode}');
    return response.statusCode == 200;
  }
}
