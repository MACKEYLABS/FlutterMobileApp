import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import 'fillquestion.dart';
import './main.dart';

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
    var questionType = questions[questionIndex]['questionType'] as QuestionType;
    Widget questionWidget;

    if (questionType == QuestionType.TrueOrFalse) {
      questionWidget = Column(
        children: [
          if (questions[questionIndex]['image'] != null)
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                questions[questionIndex]['image'] as String,
                fit: BoxFit.cover,
              ),
            ),
          Question(questions[questionIndex]['questionText'] as String),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Answer(() => answerQuestion(answer['score'] as int),
                answer['text'] as String);
          }).toList(),
        ],
      );
    }

    bool isFillIn = questions[questionIndex]['isFillIn'] as bool? ?? false;
    if (isFillIn) {
      questionWidget = Column(
        children: [
          if (questions[questionIndex]['image'] != null)
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.asset(
                questions[questionIndex]['image'] as String,
                fit: BoxFit.cover,
              ),
            ),
          Fillquestion(
            questions[questionIndex]['questionText'] as String,
            (String value) {
              answerQuestion(
                  value == questions[questionIndex]['correctAnswer'] as String
                      ? 1
                      : 0);
            },
          ),
        ],
      );
    } else {
      questionWidget = Column(
        children: [
          if (questions[questionIndex]['image'] != null)
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                questions[questionIndex]['image'] as String,
                fit: BoxFit.cover,
              ),
            ),
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

    return questionWidget;
  }
}
