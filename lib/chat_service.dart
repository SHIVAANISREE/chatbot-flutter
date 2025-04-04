import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String baseUrl = 'http://192.168.48.180:5000/chat'; // Change this to your actual backend URL

  static Future<String> getChatResponse(String message) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'] ?? 'No response';
      } else {
        return 'Error: ${response.statusCode} ${response.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
