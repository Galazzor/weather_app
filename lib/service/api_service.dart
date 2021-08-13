import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> getJson(String url) async {
    http.Response response =
        await http.get(Uri.parse(this.baseUrl + '/' + url));

    if (response.statusCode != 200) {
      return null;
    }

    String data = response.body;

    return json.decode(data);
  }
}
