import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Text('Your score: $score'),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('scores').add({
              'score': score,
              'timestamp': DateTime.now(),
            });
          },
          child: const Text('Save Score'),
        ),
      ],
    );
  }
}
