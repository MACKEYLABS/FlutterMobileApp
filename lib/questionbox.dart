import 'package:flutter/material.dart';
import 'answer.dart';

class QuestionBox extends StatelessWidget {
  final Map<String, Object> question;
  final Function answerQuestion;

  const QuestionBox(
      {super.key, required this.question, required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(question['questionText'] as String), // Cast Object? to String.
        //new if statement
        if (question['image'] != null)
          Image.asset(
            question['image'] as String, // Cast Object? to String.
            fit: BoxFit.contain, //size of picture
            width: double.infinity, // Use all available horizontal space.
            height: MediaQuery.of(context).size.height *
                0.3, // Use 30% of the screen height.
          ),

        //new if statement ending
        ...(question['answers'] as List<Map<String, Object>>).map((answer) {
          return Answer(() => answerQuestion(answer['score'] as int),
              answer['text'] as String);
        }).toList()
      ],
    );
  }
}
