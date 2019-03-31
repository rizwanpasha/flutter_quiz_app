import 'package:flutter/material.dart';
import 'package:fulutter_quiz_app/utils/quiz_service.dart';
import 'utils/quiz_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const int PRIMARY_COLOR = 0xFF2C4058;
const int SECONDARY_COLOR = 0xFFE78230;
const int BACKGROUND_COLOR = 0xFF242A40;

void main() {
  runApp(MyApp());

  //loadQuestions(quizCategories["Animations"]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color(PRIMARY_COLOR),
      ),
      home: Scaffold(
          backgroundColor: Color(BACKGROUND_COLOR),
          appBar: AppBar(
            title: Text(
              'Quiz App',
              style: TextStyle(fontSize: 26.0),
            ),
            centerTitle: true,
          ),
          body: QuizCategories()),
    );
  }
}

class QuizCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                              onTap: () {},
                              splashColor:
                                  Color(categoryColor).withOpacity(0.4),
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
                        padding: EdgeInsets.all(10.0),
                        child: Text("TODO: Show stastics of $categoryTitle"),
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
      return Icon(FontAwesomeIcons.volleyballBall, color: Color(iconColor));
      break;
  }
}
