import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> exerciseRecords;

  ResultScreen({required this.exerciseRecords});

  @override
  Widget build(BuildContext context) {
    int totalWeight = 0;
    List<Widget> exerciseSummaries = [];

    exerciseRecords.forEach((exercise, sets) {
      int maxWeight = 0;
      int maxReps = 0;
      for (var set in sets) {
        int weight = set['weight'] ?? 0;
        int reps = set['reps'] ?? 0;
        totalWeight += weight * reps;
        if (weight * reps > maxWeight * maxReps) {
          maxWeight = weight;
          maxReps = reps;
        }
      }

      exerciseSummaries.add(
        ListTile(
          title: Text('$exercise: ${sets.length}세트'),
          subtitle: Text('최고 세트: ${maxWeight}kg x ${maxReps}'),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text('결과 기록')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('오늘의 총 중량: $totalWeight kg', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Column(children: exerciseSummaries),
          ],
        ),
      ),
    );
  }
}
