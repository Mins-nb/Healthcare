import 'package:flutter/material.dart';
import 'ai_feedback_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('회원님, 운동하셔야죠.', style: TextStyle(fontSize: 40.0)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AIFeedbackScreen()),
                );
              },
              child: Text('AI 트레이너'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Text('운동 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
