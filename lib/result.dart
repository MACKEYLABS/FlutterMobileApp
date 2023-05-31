import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(this.resultScore, this.resetHandler, {super.key});

  String get resultPhrase {
    String resultText = 'You did it!';
    if (resultScore == 1) {
      resultText = 'You only got 1 answer right. ';
    } else if (resultScore <= 2) {
      resultText = 'You got 2/3 correct!';
    } else if (resultScore <= 3) {
      resultText = 'You scorred 100%!';
    } else {
      resultText = 'You scored a 0!';
    }
    return resultText;
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
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // This is the textColor equivalent
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
