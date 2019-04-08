import 'package:flutter/material.dart';
import 'utils/quiz_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'PlayQuiz.dart';
import 'utils/constants.dart';
import "QuizStatistics.dart";

void main() {
  runApp(MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color(PRIMARY_COLOR),
      ),
      home: MainPage()));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(BACKGROUND_COLOR),
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: TextStyle(fontSize: 26.0),
        ),
        centerTitle: true,
      ),
      body: QuizCategories(),
    );
  }
}

class QuizCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      itemCount: QUIZ_DATA.length,
      itemBuilder: (BuildContext context, int index) {
        String categoryTitle = QUIZ_DATA[index]['title'];
        String categoryIcon = QUIZ_DATA[index]['icon'];
        int categoryColor = int.parse(QUIZ_DATA[index]['color']);

        return Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Card(
                clipBehavior: Clip.hardEdge,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayQuiz(
                                            categoryTitle, categoryColor)));
                              },
                              splashColor:
                                  Color(categoryColor).withOpacity(0.5),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    categoryIcons(categoryIcon, categoryColor),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0)),
                                    Text(
                                      categoryTitle,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(categoryColor)),
                                    )
                                  ],
                                ),
                              ))),
                      Container(
                        child: QuizStatistics(
                            key: UniqueKey(),
                            currentQuestionCount: 2,
                            totalQuestionsCount: 10,
                            points: 50,
                            fontSize: 15.0,
                            themeColor: categoryColor),
                      )
                    ])));
      },
    );
  }
}

Icon categoryIcons(String iconName, int iconColor) {
  const double fontSize = 30.0;
  switch (iconName) {
    case 'brain':
      return Icon(
        FontAwesomeIcons.brain,
        size: fontSize,
        color: Color(iconColor),
      );
      break;
    case 'paw':
      return Icon(FontAwesomeIcons.paw,
          size: fontSize, color: Color(iconColor));
      break;
    case 'music':
      return Icon(FontAwesomeIcons.music,
          size: fontSize, color: Color(iconColor));
      break;
    case 'microscope':
      return Icon(FontAwesomeIcons.microscope,
          size: fontSize, color: Color(iconColor));
      break;
    case 'globeAfrica':
      return Icon(FontAwesomeIcons.globeAfrica,
          size: fontSize, color: Color(iconColor));
      break;
    case 'scroll':
      return Icon(FontAwesomeIcons.scroll,
          size: fontSize, color: Color(iconColor));
      break;
    case 'leaf':
      return Icon(FontAwesomeIcons.leaf,
          size: fontSize, color: Color(iconColor));
      break;
    case 'volleyballBall':
      return Icon(FontAwesomeIcons.volleyballBall,
          size: fontSize, color: Color(iconColor));
      break;
  }
}
