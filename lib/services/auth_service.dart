import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServices {
  Future<Map> sendDataToLogin(Map body) async {
    final response =
        await http.post(Uri.parse('http://roocket.org/api/login'), body: body);
    var responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<bool> checkApiToken(String apiToken) async {
    final response = await http.get(
        Uri.parse('http://roocket.org/api/user?api_token=${apiToken}'),
        headers: {'Accept': 'application/json'});
    return response.statusCode == 200;
  }
}
