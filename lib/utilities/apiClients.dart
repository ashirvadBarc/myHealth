import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medical_app/constants/ApiConst.dart';

class ApiClient {
  final httpClient = http.Client();

  Future<dynamic> callGetAPI(String endpoint) async {
    try {
      http.Response response = await http.get(Uri.parse('$baseURL$endpoint}'),
          headers: {"Content-Type": "Application/json"});

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> callPostAPI(String enterEndpoint, Map body) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('$baseURL$enterEndpoint'),
        headers: {
          'Content-Type': 'application/json', // Add this line
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // If the response is not JSON, return the boolean directly
        throw jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> callDeleteAPI() async {
    try {} catch (e) {}
  }

  Future<dynamic> callPutAPI() async {
    try {} catch (e) {}
  }
}
