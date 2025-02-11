import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class AIFeedbackScreen extends StatefulWidget {
  @override
  _AIFeedbackScreenState createState() => _AIFeedbackScreenState();
}

class _AIFeedbackScreenState extends State<AIFeedbackScreen> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController muscleMassController = TextEditingController();
  final TextEditingController fatMassController = TextEditingController();
  String gender = '남성';
  String feedback = '';

  void fetchFeedback() async {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;
    double muscleMass = double.tryParse(muscleMassController.text) ?? 0;
    double fatMass = double.tryParse(fatMassController.text) ?? 0;

    if (height <= 0 || weight <= 0) { // 키와 몸무게가 0 이하인 경우
      setState(() {
        feedback = '키와 몸무게를 정확히 입력해주세요.';
      });
      return;
    }
    if(muscleMass < 0 || fatMass < 0){ // 골격근량과 체지방량이 음수인 경우
      setState(() {
        feedback = '골격근량과 체지방량을 정확히 입력해주세요.';
      });
      return;
    }


    String? result = await GeminiService.getAIFeedback(
      height: height,
      weight: weight,
      muscleMass: muscleMass,
      fatMass: fatMass,
      gender: gender,
    );

    setState(() {
      feedback = result ?? '피드백을 불러올 수 없습니다.'; // null safety 적용
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI 트레이너')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: '키 (cm)'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: '몸무게 (kg)'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능
            ),
            TextField(
              controller: muscleMassController,
              decoration: InputDecoration(labelText: '골격근량 (kg)'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능
            ),
            TextField(
              controller: fatMassController,
              decoration: InputDecoration(labelText: '체지방량 (kg)'),
              keyboardType: TextInputType.number, // 숫자만 입력 가능
            ),
            DropdownButton<String>(
              value: gender,
              onChanged: (newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: ['남성', '여성'].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchFeedback,
              child: Text('AI 피드백 받기'),
            ),
            SizedBox(height: 20),
            // 피드백 텍스트를 스크롤 가능한 영역에 표시
            SingleChildScrollView(
              child: Text(feedback, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}