import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = 'AIzaSyDvfmgK3gngrigyrgmWY2XkSXsYa0ePQoE'; // API 키를 안전하게 관리하세요.
  static const String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  static Future<String?> getAIFeedback({
    required double height,
    required double weight,
    required double muscleMass,
    required double fatMass,
    required String gender,
  }) async {
    if (apiKey.isEmpty) {
      return 'API 키가 설정되지 않았습니다.';
    }

    final prompt = '''
      키: $height cm, 몸무게: $weight kg, 골격근량: $muscleMass kg, 체지방량: $fatMass kg, 성별: $gender 입니다.
      현재 몸 상태를 평가하고, 근육량이 부족한지 또는 체지방을 줄여야 하는지에 대해 트레이너로서 조언해 주세요.
      또한 하루 적정 단백질 섭취량(체중 1kg당 1.6~2.2g)을 계산해서 알려 주세요.
    ''';

    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ],
          "generationConfig": {
            "temperature": 0.7,
            "top_k": 40,
            "top_p": 0.95,
            "max_output_tokens": 512
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('candidates') && data['candidates'].isNotEmpty) {
          return data['candidates'][0]['content']['parts'][0]['text'];
        } else {
          return '응답 데이터 형식이 예상과 다릅니다: ${response.body}';
        }
      } else {
        return '오류 발생: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return '오류 발생: $e';
    }
  }
}