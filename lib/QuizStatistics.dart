import "package:flutter/material.dart";

class QuizStatistics extends StatefulWidget {
  int currentQuestionCount;
  int totalQuestionsCount;
  int points;
  double fontSize;
  int themeColor;

  QuizStatistics(
      {Key key,
      int currentQuestionCount,
      int totalQuestionsCount,
      int points,
      double fontSize,
      int themeColor})
      : super(key: key) {
    this.currentQuestionCount = currentQuestionCount;
    this.totalQuestionsCount = totalQuestionsCount;
    this.points = points;
    this.fontSize = fontSize;
    this.themeColor = themeColor;
  }

  QuizStatisticsState createState() => QuizStatisticsState(
      currentQuestionCount: currentQuestionCount,
      totalQuestionsCount: totalQuestionsCount,
      points: points,
      fontSize: fontSize,
      themeColor: themeColor);
}

class QuizStatisticsState extends State<QuizStatistics> {
  int currentQuestionCount;
  int totalQuestionsCount;
  int points;
  double fontSize;
  int themeColor;

  void initState() {
    super.initState();
  }

  QuizStatisticsState(
      {int currentQuestionCount,
      int totalQuestionsCount,
      int points,
      double fontSize,
      int themeColor}) {
    this.currentQuestionCount = currentQuestionCount;
    this.totalQuestionsCount = totalQuestionsCount;
    this.points = points;
    this.fontSize = fontSize;
    this.themeColor = themeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Question $currentQuestionCount / $totalQuestionsCount",
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  "$points points",
                  style: TextStyle(fontSize: fontSize),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: LinearProgressIndicator(
                value: (currentQuestionCount / totalQuestionsCount).isNaN
                    ? 0
                    : (currentQuestionCount / totalQuestionsCount),
                backgroundColor: Color(themeColor).withOpacity(0.5),
                valueColor: AlwaysStoppedAnimation<Color>(Color(themeColor)),
              ),
            )
          ]),
    );
  }
}
