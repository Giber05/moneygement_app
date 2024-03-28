// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:moneygement_app/infrastructure/ext/ctx_ext.dart';
import 'package:moneygement_app/infrastructure/ext/double_ext.dart';
import 'package:moneygement_app/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:moneygement_app/infrastructure/widgets/layouts/dialog/dialog_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:moneygement_app/infrastructure/widgets/loading/circular.dart';
import 'package:moneygement_app/modules/quizz/domain/models/quiz_model.dart';
import 'package:moneygement_app/modules/quizz/presentation/bloc/quiz_bloc.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';

part 'widgets/quiz_stepper.dart';
part 'widgets/question.dart';
part 'widgets/result.dart';

@RoutePage()
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuizBloc>()..add(GetQuizEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quizz'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == "Profile") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Current user token: ${context.userSession.token}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else if (value == "Logout") {
                    ConfirmationDialog.launch(
                      context,
                      title: 'Are You Sure Want to Logout?',
                      onConfirm: (VoidCallback closeDialog) {
                        context.logout();
                        closeDialog();
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Profile',
                    child: Text('Profile'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: Text('Logout'),
                  ),
                ],
                child: const Icon(
                  Icons.account_circle_rounded,
                  size: 40,
                ),
              ),
            )
          ],
        ),
        body: const _QuizContent(),
      ),
    );
  }
}

class _QuizContent extends StatelessWidget {
  const _QuizContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is GetQuizSuccess) {
          context.read<QuizBloc>().add(CachedQuizzesEvent(state.quizData));
        }
      },
      builder: (context, state) {
        if (state is GetQuizLoading) {
          return const Center(child: CBCircularLoading());
        } else if (state is GetQuizSuccess) {
          return _QuizStepper(quizData: state.quizData);
        } else if (state is GetQuizFailed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(state.message)),
              16.verticalSpace,
              MGElevatedButton(
                label: 'Refresh',
                onPressed: () {
                  context.read<QuizBloc>().add(GetQuizEvent());
                },
              )
            ],
          );
        }
        return Container(); // Placeholder for other states
      },
    );
  }
}
