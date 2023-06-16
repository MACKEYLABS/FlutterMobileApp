import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;
  final int totalQuestions;

  const Result(this.resultScore, this.resetHandler, this.totalQuestions,
      {Key? key})
      : super(key: key);

  String get resultPhrase {
    String resultText;
    double percentage = (resultScore / totalQuestions) * 100;

    if (percentage <= 20) {
      resultText = 'You are a Linux Failure.';
    } else if (percentage <= 40) {
      resultText = 'You only got two questions right, come on!';
    } else if (percentage <= 60) {
      resultText = 'You still don\'t know that much about Linus.';
    } else if (percentage <= 80) {
      resultText = 'Ok, you\'re Linux knowledge is starting to impress me!';
    } else {
      resultText = 'You are a Linux genius!!!';
    }

    return '$resultText\nYou scored ${percentage.toStringAsFixed(2)}%!';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Score: $resultScore/$totalQuestions',
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.blue, // This is the textColor equivalent
            ),
            onPressed: resetHandler,
            child: const Text(
              'Restart Quiz',
            ),
          ),
        ],
      ),
    );
  }
}
