import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_progress_provider.dart';
import 'providers/lesson_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/progress_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const TalkAlingoApp());
}

class TalkAlingoApp extends StatelessWidget {
  const TalkAlingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProgressProvider()),
        ChangeNotifierProvider(create: (_) => LessonProvider()),
      ],
      child: MaterialApp(
        title: 'TalkAlingo',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/lesson': (context) => const LessonScreen(),
          '/practice': (context) => const PracticeScreen(),
          '/progress': (context) => const ProgressScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}