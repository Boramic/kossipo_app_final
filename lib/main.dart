import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'app/routes/app_router.dart';
import 'app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KossipoApp());
}

class KossipoApp extends StatelessWidget {
  const KossipoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kossipo',
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRouter.onGenerateRoute,

      themeMode: ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}