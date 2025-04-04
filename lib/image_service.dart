import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  static const String baseUrl = 'http://192.168.48.180:5000/generate-image'; // Replace with your actual URL

  static Future<String?> generateImage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['image'];
      } else {
        final error = jsonDecode(response.body);
        return "Error: ${error['error']}";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
