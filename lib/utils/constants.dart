import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String appname = "Maxcloud";
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';
}
