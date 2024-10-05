import 'package:flutter/material.dart';

class MentalHealthAssessmentScreen extends StatefulWidget {
  @override
  _MentalHealthAssessmentScreenState createState() =>
      _MentalHealthAssessmentScreenState();
}

class _MentalHealthAssessmentScreenState
    extends State<MentalHealthAssessmentScreen> {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _currentQuestionIndex += 1;
    });

    if (_currentQuestionIndex < mentalHealthQuestions.length) {
      // Proceed to the next question
    } else {
      // All questions answered, show the result
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    String resultMessage;

    if (_totalScore <= 5) {
      resultMessage = 'Low stress level';
    } else if (_totalScore <= 8) {
      resultMessage = 'Moderate stress level';
    } else {
      resultMessage = 'High stress level';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assessment Result'),
        content: Text(resultMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetAssessment();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetAssessment() {
    setState(() {
      _currentQuestionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'Mental Health Assessment',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: _currentQuestionIndex < mentalHealthQuestions.length
          ? _buildQuestionUI()
          : Center(
              child: Text('Assessment completed'),
            ),
    );
  }

  Widget _buildQuestionUI() {
    final currentQuestion = mentalHealthQuestions[_currentQuestionIndex];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    currentQuestion.questionText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                ...currentQuestion.answers.map((answer) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.purple,
                        textStyle: TextStyle(fontSize: 18),
                        foregroundColor:
                            Colors.white, // Text color set to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _answerQuestion(answer['score'] as int),
                      child: Text(answer['text'] as String),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<Map<String, Object>> answers;

  Question({required this.questionText, required this.answers});
}

List<Question> mentalHealthQuestions = [
  Question(
    questionText: "How often do you feel nervous or stressed?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "Do you find it hard to relax?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "How often do you feel sad or down?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "Do you find it hard to sleep?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "How often do you feel tired or have low energy?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "Do you feel like you can’t control your worries?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
  Question(
    questionText: "Do you find it hard to focus on things?",
    answers: [
      {'text': 'Never', 'score': 1},
      {'text': 'Sometimes', 'score': 2},
      {'text': 'Often', 'score': 3},
      {'text': 'Very Often', 'score': 4},
    ],
  ),
];
