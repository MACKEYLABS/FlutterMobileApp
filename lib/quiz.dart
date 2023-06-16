import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import 'fillquestion.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function(int) answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFillIn = questions[questionIndex]['isFillIn'] as bool? ?? false;
    if (isFillIn) {
      return Fillquestion(
        questions[questionIndex]['questionText'] as String,
        (String value) {
          answerQuestion(
              value == questions[questionIndex]['correctAnswer'] as String
                  ? 1
                  : 0);
        },
      );
    } else {
      return Column(
        children: [
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Answer(() => answerQuestion(answer['score'] as int),
                answer['text'] as String);
          }).toList()
        ],
      );
    }
  }
}
