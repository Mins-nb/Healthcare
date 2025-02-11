import 'package:flutter/material.dart';
import 'set_record_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> exercises = ['벤치프레스 (바벨)', '벤치프레스 (덤벨)', '스쿼트', '데드리프트', '밀리터리 프레스', '레그 익스텐션', '인클라인 덤벨프레스', '랫 풀 다운', '바벨 로우', '바벨 컬'];
  List<String> selectedExercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('종목 찾기')),
      body: ListView(
        children: exercises.map((exercise) {
          return ListTile(
            title: Text(exercise),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (!selectedExercises.contains(exercise)) {
                    selectedExercises.add(exercise);
                  }
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SetRecordScreen(selectedExercises: selectedExercises),
                  ),
                );
              },
              child: Text('종목 추가'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
