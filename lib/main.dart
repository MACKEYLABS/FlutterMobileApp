import './quiz.dart';
import './result.dart';
import 'package:flutter/material.dart';

enum QuestionType {
  MultipleChoice,
  FillInTheBlank,
  TrueOrFalse,
}

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
      'questionType': QuestionType.MultipleChoice,
      'answers': [
        {'text': 'sudo apt-get update', 'score': 1},
        {'text': 'sudo update distro', 'score': 0},
        {'text': 'apt-update', 'score': 0},
        {'text': 'apt get update', 'score': 0},
      ]
    },
    {
      'questionText': 'What command do you use to upgrade a Linux distro?',
      'questionType': QuestionType.MultipleChoice,
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
      'questionType': QuestionType.MultipleChoice,
      'answers': [
        {'text': 'sudo apt upgrade && update', 'score': 0},
        {'text': 'sudo apt-get update && upgrade', 'score': 0},
        {'text': 'apt-get update && upgrade', 'score': 0},
        {'text': 'sudo apt-get update && sudo apt-get upgrade', 'score': 1},
      ],
    },
    {
      'questionText': 'Who is considered the founder of Linux?',
      'questionType': QuestionType.FillInTheBlank,
      'correctAnswer': 'Linus Torvalds',
      'isFillIn': true,
      'totalScore': 1,
      'image': 'assets/linus1.jpeg', //path to the 1st linus image
    },
    {
      'questionText':
          'What is the most popular penetration testing distrobution of Linux?',
      'questionType': QuestionType.FillInTheBlank,
      'correctAnswer': 'Kali',
      'isFillIn': true,
      'totalScore': 1,
      'image': 'assets/kali1.jpeg', //2nd path to kali linux image
    },
    {
      'questionText':
          'Fedora is Debian based and has no similarities to Red Hat Liunux',
      'questionType': QuestionType.TrueOrFalse,
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1}
      ],
      'image': 'assets/fedora.jpeg',
    },
    {
      'questionText': 'Is the picture shown Ubuntu Linux?',
      'questionType': QuestionType.TrueOrFalse,
      'answers': [
        {'text': 'True', 'score': 1},
        {'text': 'False', 'score': 0}
      ],
      'totalScore': 1,
      'image': 'assets/ubuntu.jpeg',
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
                  _toggleDarkMode), // Fixed line
        ),
      ),
    );
  }
}
