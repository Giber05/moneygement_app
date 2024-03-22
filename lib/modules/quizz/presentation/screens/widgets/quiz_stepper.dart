part of '../quiz_screen.dart';

class _QuizStepper extends StatelessWidget {
  final List<QuizModel> quizData;
  final ValueNotifier<int> _currentQuestionIndex = ValueNotifier<int>(0);
  final ValueNotifier<int> _score = ValueNotifier<int>(0);
  final ValueNotifier<int> _wrongAttempts = ValueNotifier<int>(0);

  _QuizStepper({
    Key? key,
    required this.quizData,
  }) : super(key: key);

  void _answerQuestion(BuildContext context, String answer) {
    if (quizData[_currentQuestionIndex.value].typeQuestion == 'multichoice') {
      final correctAnswer = quizData[_currentQuestionIndex.value]
          .data
          .firstWhere((option) => option.value == quizData[_currentQuestionIndex.value].value);
      bool isCorrect = answer == correctAnswer.value;

      if (isCorrect) {
        _score.value++;
        _currentQuestionIndex.value++;
        _wrongAttempts.value = 0;
      } else {
        _wrongAttempts.value++;

        if (_wrongAttempts.value < 3) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Incorrect'),
                content: const Text('Oops, your answer is incorrect. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          final correctAnswerText = correctAnswer.text;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Incorrect'),
                content: RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: 'Oops, your answer is incorrect. The correct answer is: '),
                    TextSpan(
                      text: correctAnswerText,
                      style: const TextStyle(fontWeight: FontWeight.bold), // Buat teks ini bold
                    ),
                  ],
                )),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _currentQuestionIndex.value++;
                      _wrongAttempts.value = 0;
                    },
                    child: const Text('Next'),
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      _currentQuestionIndex.value++;
    }
  }

  void _resetQuiz() {
    _currentQuestionIndex.value = 0;
    _score.value = 0;
    _wrongAttempts.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<int>(
          valueListenable: _currentQuestionIndex,
          builder: (_, currentIndex, __) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FlutterStepIndicator(
                    height: 20,
                    durationScroller: const Duration(seconds: 1),
                    onChange: (int index) {},
                    page: currentIndex,
                    list: quizData,
                  ),
                ),
                currentIndex < quizData.length
                    ? _QuestionItem(
                        question: quizData[currentIndex],
                        answerQuestion: (answer) => _answerQuestion(context, answer),
                        currentQuestionIndex: currentIndex,
                        totalQuestions: quizData.length,
                        wrongAttemps: _wrongAttempts,
                        onNext: () {
                          _currentQuestionIndex.value++;
                        },
                      )
                    : _ResultQuiz(
                        score: _score.value,
                        totalQuestions:
                            quizData.where((element) => element.typeQuestion != 'description').toList().length,
                        resetQuiz: _resetQuiz,
                      ),
              ],
            );
          }),
    );
  }
}
