import 'package:intl/date_symbol_data_local.dart';
import 'package:moneygement_app/infrastructure/supabase/supabase_config.dart';
import 'package:moneygement_app/modules/quizz/data/mapper/local/models/quiz.dart';
import 'package:flutter/material.dart';
import 'package:moneygement_app/app.dart';
import 'package:moneygement_app/infrastructure/architecutre/error_handler/global_error_handler.dart';
import 'package:moneygement_app/infrastructure/env/env.dart';
import 'package:moneygement_app/infrastructure/routing/router.dart';
import 'package:moneygement_app/infrastructure/service_locator/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'modules/quizz/data/mapper/local/models/quiz_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  MGGlobalErrorHandler.setUpErrorHandler();
  await Hive.initFlutter();
  Hive.registerAdapter(QuizAdapter());
  Hive.registerAdapter(QuizDataAdapter());
  await Hive.openBox('quizBox');
  ENV.setEnv(ENV.dev);
  await getIt<SupabaseConfig>().setup();
  initializeDateFormatting();
  runApp(MoneyGementApp(
    appRouter: AppRouter(),
  ));
}
