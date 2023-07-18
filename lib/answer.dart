import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final void Function() selectHandler;
  final String answerText;

  const Answer(
    this.selectHandler,
    this.answerText, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        width:
            MediaQuery.of(context).size.width * 0.8, // 80% of the total width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, // foreground (text color)
            textStyle: const TextStyle(
              fontSize: 16,
            ),
            minimumSize: const Size(
              double
                  .infinity, // This makes the button's width to fill the parent (SizedBox)
              50, // This is the height
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: selectHandler,
          child: Text(answerText),
        ),
      ),
    );
  }
}
