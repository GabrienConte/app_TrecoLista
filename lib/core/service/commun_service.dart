
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractService{

  static const String baseUrl = 'http://172.21.52.40:5075/api/v1';

  Future<Map<String, String>> getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> getHeaderToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    return {
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, String>> getHeadersSemContent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    return {
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}