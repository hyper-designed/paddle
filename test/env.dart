import 'package:dotenv/dotenv.dart';

final DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

final String? apiKey = env['PADDLE_API_KEY'];
final String testEmail = env['TEST_EMAIL']!;
