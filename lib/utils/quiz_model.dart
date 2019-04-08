class Quiz {
  final String _category;
  final List<Questions> _questions;
  int currentQuestionCount = 0;
  Quiz(this._category, this._questions);

  factory Quiz.fromJson(Map<String, dynamic> parsedJson) {
    List<Questions> questions = new List<Questions>();
    questions = List<Questions>.from(
        parsedJson['questions'].map((i) => Questions.fromJson(i)).toList());

    questions.shuffle();
    return Quiz(parsedJson['category'], questions);
  }

  String get category => this._category;
  int get totalNumberOfQuestions => this._questions.length;
  Questions get getQuestion => this.getNextQuestion();

  Questions getNextQuestion() {
    if ((currentQuestionCount + 1) > _questions.length) {
      return null;
    } else {
      return _questions[currentQuestionCount++];
    }
  }
}

class Questions {
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Questions({this.question, this.correctAnswer, this.incorrectAnswers});

  factory Questions.fromJson(Map<String, dynamic> parsedJson) {
    List<String> incorrectAnswers =
        new List<String>.from(parsedJson['incorrect_answers']);
    incorrectAnswers.shuffle();
    return Questions(
        question: parsedJson['question'],
        correctAnswer: parsedJson['correct_answer'],
        incorrectAnswers: incorrectAnswers);
  }
}
