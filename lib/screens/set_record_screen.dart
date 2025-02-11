import 'package:flutter/material.dart';
import 'result_screen.dart';

class SetRecordScreen extends StatefulWidget {
  final List<String> selectedExercises;

  SetRecordScreen({required this.selectedExercises});

  @override
  _SetRecordScreenState createState() => _SetRecordScreenState();
}

class _SetRecordScreenState extends State<SetRecordScreen> {
  Map<String, List<Map<String, dynamic>>> exerciseRecords = {};

  @override
  void initState() {
    super.initState();
    for (var exercise in widget.selectedExercises) {
      exerciseRecords.putIfAbsent(exercise, () => []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('세트 기록')),
      body: ListView(
        children: widget.selectedExercises.map((exercise) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(exercise, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        exerciseRecords[exercise]?.add({
                          'weight': 0,
                          'reps': 0,
                          'success': false,
                          'weightController': TextEditingController(),
                          'repsController': TextEditingController(),
                        });
                      });
                    },
                    child: Text('세트 추가'),
                  ),
                ),
                Column(
                  children: exerciseRecords[exercise]!.asMap().entries.map((entry) {
                    int index = entry.key;
                    var record = entry.value;
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: record['weightController'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: '무게 (kg)'),
                              onChanged: (value) {
                                setState(() {
                                  exerciseRecords[exercise]![index]['weight'] = int.tryParse(value) ?? 0;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: record['repsController'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: '횟수'),
                              onChanged: (value) {
                                setState(() {
                                  exerciseRecords[exercise]![index]['reps'] = int.tryParse(value) ?? 0;
                                });
                              },
                            ),
                          ),
                          Checkbox(
                            value: record['success'],
                            onChanged: (value) {
                              setState(() {
                                exerciseRecords[exercise]![index]['success'] = value;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                exerciseRecords[exercise]?.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(exerciseRecords: exerciseRecords),
            ),
          );
        },
      ),
    );
  }
}
