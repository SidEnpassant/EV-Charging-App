import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chargerrr/core/routes/app_pages.dart';
import 'package:chargerrr/core/theme/app_theme.dart';
import 'package:chargerrr/core/utils/app_constants.dart';
import 'package:chargerrr/core/di/dependency_injection.dart';
import 'package:chargerrr/app_credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialized Supabase
  await Supabase.initialize(
    url: AppCredentials.supabaseURL,
    anonKey: AppCredentials.supabaseAnon,
  );
  // Initialized dependencies
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
