part of '../quiz_screen.dart';

class _ResultQuiz extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback resetQuiz;

  const _ResultQuiz({
    required this.score,
    required this.totalQuestions,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your score is $score/$totalQuestions',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetQuiz,
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
