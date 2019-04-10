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
  int pointsScored;
  int point = 50;

  void initState() {
    super.initState();
    setState(() {
      currentQuestion = "";
      incorrectAnswers = [];
      correctAnswer = "";
      totalQuestionsCount = 0;
      currentQuestionCount = 0;
      pointsScored = 0;
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
    setState(() {
      if (answerStatus == "correctAnswer") {
        pointsScored += point;
      }
    });

    if (this.questionObject == null) {
      endOfQuiz();
    } else {
      setState(() {
        totalQuestionsCount = quiz.totalNumberOfQuestions;
        currentQuestionCount = quiz.currentQuestionCount;
        currentQuestion = questionObject.question;
        incorrectAnswers = questionObject.incorrectAnswers;
        correctAnswer = questionObject.correctAnswer;
      });
      print("$currentQuestionCount $totalQuestionsCount $currentQuestion");
    }
  }

  endOfQuiz() {
    int attemptedQuestions = (pointsScored / point).truncate();
    print("end of quiz");

    String headerMessage = "";
    int maxPoints = currentQuestionCount * point;
    int rating = ((pointsScored / maxPoints) * 100).truncate();
    print(maxPoints);
    print(rating);
    print(rating == 0);
    if (rating == 0) {
      headerMessage = "oops!";
    } else if (rating >= 25.0 && rating < 40.0) {
      headerMessage = "not bad.";
    } else if (rating >= 40.0 && rating < 75.0) {
      headerMessage = "smart.";
    } else if (rating >= 75.0 && rating < 95.0) {
      headerMessage = "great job.";
    } else if (rating >= 95.0 && rating < 100) {
      headerMessage = "scholar.";
    } else if (rating == 100) {
      headerMessage = "master of knowledge.";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$headerMessage",
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "$pointsScored points.",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "You answered $attemptedQuestions/$totalQuestionsCount question correctly.",
                  style: TextStyle(fontSize: 15.0),
                ),
              )
            ],
          ),
          actions: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                child: Text("Back to quiz.")),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() {
    bool shouldClose = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Are you sure"),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new RaisedButton(
                        color: Colors.orange,
                        onPressed: () {
                          Navigator.pop(context);
                          return shouldClose = true;
                        },
                        child: new Text('Yes'),
                      ),
                      new RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.pop(context);
                          return shouldClose = false;
                        },
                        child: new Text('No'),
                      ),
                    ],
                  ),
                ],
              ));
        });

    if (shouldClose) {
      Navigator.pop(context);
    }

    return Future.value(shouldClose);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                      points: pointsScored,
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
                            color: Colors.green,
                            alignment: AlignmentDirectional.bottomCenter,
                            height: 200.0,
                            child: ListView.builder(
                              itemCount: incorrectAnswers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RaisedButton(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
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
                                          color: Color(categoryColor),
                                          width: 2.0),
                                      borderRadius: BorderRadius.circular(3.0)),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    margin:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  ),
                  flex: 5,
                )
              ],
            )));
  }
}
