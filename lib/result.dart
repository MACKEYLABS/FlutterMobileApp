import 'package:flutter/material.dart';
import 'package:test_app/LeaderboardWidget.dart';
import 'ScoreWidget.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;
  final int totalQuestions;
  final Function toggleTheme; //added a function for the theme toggle

  const Result(this.resultScore, this.resetHandler, this.totalQuestions,
      this.toggleTheme,
      {Key? key}) //added this.toggleTheme
      : super(key: key);

  String get resultPhrase {
    String resultText;
    double percentage = (resultScore / totalQuestions) * 100;
    if (percentage <= 20) {
      resultText = 'You are a Linux Failure.';
    } else if (percentage <= 40) {
      resultText = 'You only got two questions right, come on!';
    } else if (percentage <= 60) {
      resultText = 'You still don\'t know that much about Linux.';
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
          ElevatedButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: resetHandler,
            child: const Text(
              'Restart Quiz',
            ),
          ),
          ScoreWidget(score: resultScore),
          const Expanded(child: LeaderboardWidget()),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(
                      title: Text('Leaderboard'),
                    ),
                    body: const LeaderboardWidget(),
                  ),
                ),
              );
            },
            child: const Text('View Leaderboard'),
          ),
        ],
      ),
    );
  }
}
