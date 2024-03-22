import 'package:moneygement_app/infrastructure/env/env.dart';

class NetworkConstants {
  static String apiBaseUrl = "${ENV.current.baseURL}/api/v2";
  static String apiAuthUrl = "${ENV.current.authURL}/api";
}
