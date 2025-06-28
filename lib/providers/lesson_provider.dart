import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/lesson_service.dart';

class LessonProvider with ChangeNotifier {
  final LessonService _lessonService = LessonService();
  
  List<Lesson> _lessons = [];
  Lesson? _currentLesson;
  List<PracticeExercise> _currentExercises = [];
  int _currentExerciseIndex = 0;
  int _currentScore = 0;

  List<Lesson> get lessons => _lessons;
  Lesson? get currentLesson => _currentLesson;
  List<PracticeExercise> get currentExercises => _currentExercises;
  int get currentExerciseIndex => _currentExerciseIndex;
  int get currentScore => _currentScore;
  
  bool get hasNextExercise => _currentExerciseIndex < _currentExercises.length - 1;
  PracticeExercise? get currentExercise => 
      _currentExercises.isNotEmpty ? _currentExercises[_currentExerciseIndex] : null;

  LessonProvider() {
    _initializeLessons();
  }

  void _initializeLessons() {
    _lessons = _lessonService.getAllLessons();
    notifyListeners();
  }

  List<Lesson> getLessonsByCategory(LessonCategory category) {
    return _lessons.where((lesson) => lesson.category == category).toList();
  }

  List<Lesson> getLessonsByLevel(UserLevel level) {
    return _lessons.where((lesson) => lesson.requiredLevel == level).toList();
  }

  void startLesson(String lessonId) {
    _currentLesson = _lessons.firstWhere((lesson) => lesson.id == lessonId);
    _currentExercises = _lessonService.generateExercisesForLesson(_currentLesson!);
    _currentExerciseIndex = 0;
    _currentScore = 0;
    notifyListeners();
  }

  bool submitAnswer(String answer) {
    if (_currentExercises.isEmpty) return false;
    
    final exercise = _currentExercises[_currentExerciseIndex];
    final isCorrect = answer.toLowerCase() == exercise.correctAnswer.toLowerCase();
    
    if (isCorrect) {
      _currentScore += 10;
    }
    
    notifyListeners();
    return isCorrect;
  }

  void nextExercise() {
    if (hasNextExercise) {
      _currentExerciseIndex++;
      notifyListeners();
    }
  }

  void completeLesson() {
    if (_currentLesson != null) {
      final lessonIndex = _lessons.indexWhere((l) => l.id == _currentLesson!.id);
      if (lessonIndex != -1) {
        _lessons[lessonIndex] = _currentLesson!.copyWith(
          isCompleted: true,
          userScore: _currentScore,
        );
      }
      
      _currentLesson = null;
      _currentExercises = [];
      _currentExerciseIndex = 0;
      _currentScore = 0;
      
      notifyListeners();
    }
  }

  void resetLesson() {
    _currentLesson = null;
    _currentExercises = [];
    _currentExerciseIndex = 0;
    _currentScore = 0;
    notifyListeners();
  }

  List<Lesson> getCompletedLessons() {
    return _lessons.where((lesson) => lesson.isCompleted).toList();
  }

  int getTotalCompletedLessons() {
    return getCompletedLessons().length;
  }

  int getTotalPoints() {
    return getCompletedLessons().fold(0, (sum, lesson) => sum + (lesson.userScore ?? 0));
  }
}