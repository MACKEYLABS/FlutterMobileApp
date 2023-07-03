import 'package:flutter/material.dart';
import 'answer.dart';

class QuestionBox extends StatelessWidget {
  final Map<String, Object> question;
  final Function answerQuestion;

  QuestionBox({required this.question, required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(question['questionText'] as String), // Cast Object? to String.
        if (question['image'] != null)
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              question['image'] as String, // Cast Object? to String.
              fit: BoxFit.cover,
            ),
          ),
        ...(question['answers'] as List<Map<String, Object>>).map((answer) {
          return Answer(() => answerQuestion(answer['score'] as int),
              answer['text'] as String);
        }).toList()
      ],
    );
  }
}
