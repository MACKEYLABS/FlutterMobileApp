import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final _questions = const [
    {
      'questionText': 'What command do you use to update a Linux distro?',
      'answers': [
        {'text': 'sudo apt-get update', 'score': 1},
        {'text': 'sudo update distro', 'score': 0},
        {'text': 'apt-update', 'score': 0},
        {'text': 'apt get update', 'score': 0},
      ]
    },
    {
      'questionText': 'What command do you use to upgrade a Linux distro?',
      'answers': [
        {'text': 'sudo upgrade distro', 'score': 0},
        {'text': 'sudo apt-get upgrade', 'score': 1},
        {'text': 'sudo apt upgrade distro', 'score': 0},
        {'text': 'upgrade distro-now', 'score': 0},
      ],
    },
    {
      'questionText':
          'What command do you use to update and upgrade a Linux distro',
      'answers': [
        {'text': 'sudo apt upgrade && update', 'score': 0},
        {'text': 'sudo apt-get update && upgrade', 'score': 0},
        {'text': 'apt-get update && upgrade', 'score': 0},
        {'text': 'sudo apt-get update && sudo apt-get upgrade', 'score': 1},
      ],
    },
    {
      'questionText': 'Who is considered the founder of Linux?',
      'correctAnswer': 'Linus Torvalds',
      'isFillIn': true,
      'totalScore': 1,
    },
    {
      'questionText': 'What is the most popular hacking distro of Linux?',
      'correctAnswer': 'Kali',
      'isFillIn': true,
      'totalScore': 1,
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  var _isDarkMode = false; //track dark mode status

  AnimationController? controller;
  Animation<double>? animation;

  int get totalPossibleScore {
    return _questions.fold(0, (sum, question) {
      var score = question['totalScore'];
      if (score is int) {
        return sum + score;
      } else {
        return sum;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller!, curve: Curves.easeInOut);

    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      controller!.reset();
      controller!.forward();
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
      if (_questionIndex < _questions.length) {
        controller!.reset();
        controller!.forward();
      }
    });
  }

// start the quiz in dark mode!
  void _restartQuizDarkMode() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _isDarkMode =
          true; //setting the dark mode to true when restarting the quiz
      controller!.reset();
      controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.blue,
              colorScheme: ThemeData.dark()
                  .colorScheme
                  .copyWith(secondary: Colors.amber),
              textTheme: ThemeData.dark()
                  .textTheme
                  .apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                    fontFamily: 'Roboto',
                  )
                  .copyWith(
                    headline6: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
          : ThemeData.light().copyWith(
              primaryColor: Colors.blue,
              colorScheme: ThemeData.light()
                  .colorScheme
                  .copyWith(secondary: Colors.amber),
              textTheme: ThemeData.light()
                  .textTheme
                  .apply(
                    bodyColor: Colors.black,
                    displayColor: Colors.black,
                    fontFamily: 'Roboto',
                  )
                  .copyWith(
                    headline6: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.brightness_6),
              onPressed: _toggleDarkMode,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '${(_questionIndex + 1).toString()}/${_questions.length.toString()}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: FadeTransition(
          opacity: animation!,
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                )
              : Result(_totalScore, _resetQuiz, _questions.length,
                  _restartQuizDarkMode), // Fixed line
        ),
      ),
    );
  }
}
