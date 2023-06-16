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
            primary: Colors.blue, // background
            onPrimary: Colors.white, // foreground (text color)
            textStyle: TextStyle(
              fontSize: 16,
            ),
            minimumSize: Size(
              double
                  .infinity, // This makes the button's width to fill the parent (SizedBox)
              50, // This is the height
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // if you need rounded corners
            ),
          ),
          onPressed: selectHandler,
          child: Text(answerText),
        ),
      ),
    );
  }
}
