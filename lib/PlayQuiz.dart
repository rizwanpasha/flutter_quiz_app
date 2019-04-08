import 'dart:io';

import "package:flutter/material.dart";
import 'utils/quiz_service.dart';
import "utils/quiz_data.dart";
import "utils/quiz_model.dart";
import 'utils/constants.dart';
import "QuizStatistics.dart";

class PlayQuiz extends StatefulWidget {
  String _selectedCategory;
  String _filePath;
  int categoryColor;

  PlayQuiz(String selectedCategory, int categoryColor) {
    this._selectedCategory = selectedCategory;
    this.categoryColor = categoryColor;

    for (var i = 0; i < QUIZ_DATA.length; i++) {
      if (QUIZ_DATA[i]["title"] == selectedCategory) {
        this._filePath = QUIZ_DATA[i]["file"];
      }
    }
  }

  @override
  PlayQuizState createState() =>
      PlayQuizState(this._selectedCategory, this._filePath, this.categoryColor);
}

class PlayQuizState extends State<PlayQuiz> with WidgetsBindingObserver {
  final global = GlobalKey();
  String category;
  int categoryColor;
  String filePath;
  Quiz quiz;
  String currentQuestion;
  List<String> incorrectAnswers;
  String correctAnswer;
  Questions questionObject;
  int currentQuestionCount;
  int totalQuestionsCount;
  int points;

  void initState() {
    super.initState();
    setState(() {
      currentQuestion = "";
      incorrectAnswers = [];
      correctAnswer = "";
      totalQuestionsCount = 0;
      currentQuestionCount = 0;
      points = 0;
    });
  }

  @override
  void dispose() {
    quiz = null;
    super.dispose();
  }

  PlayQuizState(this.category, this.filePath, this.categoryColor) {
    loadQuestions(filePath)
        .then((quizObject) => quiz = quizObject)
        .then((object) => {updateQuestionState("")});
  }

  getNextQuestion(String answerStatus) {
    updateQuestionState(answerStatus);
  }

  updateQuestionState(String answerStatus) {
    questionObject = quiz.getQuestion;
    if (this.questionObject == null) {
      endOfQuiz();
    } else {
      setState(() {
        totalQuestionsCount = quiz.totalNumberOfQuestions;
        currentQuestionCount = quiz.currentQuestionCount;
        currentQuestion = questionObject.question;
        incorrectAnswers = questionObject.incorrectAnswers;
        correctAnswer = questionObject.correctAnswer;

        if (answerStatus == "correctAnswer") {
          points += 50;
        }
      });
      print("$currentQuestionCount $totalQuestionsCount $currentQuestion");
    }
  }

  endOfQuiz() {
    print("end of quiz");
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       title: new Text("Alert Dialog title"),
    //       content: new Text("Alert Dialog body"),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         new FlatButton(
    //           child: new Text("Close"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(title: new Text('Music'), onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(category),
        ),
        backgroundColor: Color(BACKGROUND_COLOR),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Card(
                child: QuizStatistics(
                  currentQuestionCount: currentQuestionCount,
                  totalQuestionsCount: totalQuestionsCount,
                  points: points,
                  key: UniqueKey(),
                  fontSize: 20.0,
                  themeColor: categoryColor,
                ),
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              ),
              flex: 1,
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        currentQuestion,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Container(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: incorrectAnswers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RaisedButton(
                              child: Text(
                                incorrectAnswers[index],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              color: Colors.white,
                              splashColor:
                                  (incorrectAnswers[index] == correctAnswer)
                                      ? Colors.green
                                      : Colors.red,
                              onPressed: () {
                                getNextQuestion(
                                  (incorrectAnswers[index] == correctAnswer)
                                      ? "correctAnswer"
                                      : "incorrectAnswer",
                                );
                              },
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(categoryColor), width: 2.0),
                                  borderRadius: BorderRadius.circular(3.0)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              ),
              flex: 5,
            )
          ],
        ));
  }
}
