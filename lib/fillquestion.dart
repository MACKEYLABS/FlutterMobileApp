import 'package:flutter/material.dart';

class Fillquestion extends StatefulWidget {
  final String questionText;
  final void Function(String) onSubmitted;

  const Fillquestion(
    this.questionText,
    this.onSubmitted, {
    Key? key,
  }) : super(key: key);

  @override
  _FillquestionState createState() => _FillquestionState();
}

class _FillquestionState extends State<Fillquestion> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller
        .dispose(); // Don't forget to dispose of the controller when the widget is removed from the widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            widget.questionText,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          TextField(
            controller: _controller,
            onSubmitted: (value) {
              widget.onSubmitted(value);
              _controller.clear(); // Clears the textfield after submission.
            },
            textAlign: TextAlign.center, // Centers the text input.
            style: TextStyle(fontSize: 24), // Changes the text size.
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(
                  10.0), // Creates padding around the input field.
            ),
          ),
        ],
      ),
    );
  }
}
