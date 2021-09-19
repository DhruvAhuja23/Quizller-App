import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'question_brain.dart';

void main() {
  runApp(Quizller());
}

class Quizller extends StatelessWidget {
  const Quizller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int count = 0;
  QuestionBrain qb = new QuestionBrain();
  // List<String> questions = [
  //   'Approximately one quarter of human bones are in the feet.',
  //   'You can lead a cow down stairs but not up stairs.',
  //   'A slug\'s blood is green.'
  // ];
  void getIcon(bool num) {
    setState(() {
      if (qb.isFinished()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Completed!!",
          desc: "Thanks for Playing your Score is $count",
          buttons: [
            DialogButton(
              child: Text(
                "COOL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        scoreKeeper = [];
        qb.reset();
        count = 0;
      } else {
        if (qb.getAns() == num) {
          count++;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        qb.nextQuestion();
      }
    });
  }

  // List<bool> answers = [true, false, true];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                qb.getText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextButton(
              onPressed: () {
                getIcon(true);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.green),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 102.0),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: TextButton(
              onPressed: () {
                getIcon(false);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.red),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 100.0),
                child: Text(
                  'False',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
