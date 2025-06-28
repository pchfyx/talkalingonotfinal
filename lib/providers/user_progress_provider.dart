import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/models.dart';

class UserProgressProvider with ChangeNotifier {
  User? _user;
  List<Achievement> _achievements = [];
  bool _isFirstTime = true;

  User? get user => _user;
  List<Achievement> get achievements => _achievements;
  bool get isFirstTime => _isFirstTime;

  UserProgressProvider() {
    _initializeUser();
    _initializeAchievements();
  }

  Future<void> _initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    
    if (userData != null) {
      _user = User.fromJson(json.decode(userData));
      _isFirstTime = false;
    }
    
    notifyListeners();
  }

  Future<void> createUser(String name, String language) async {
    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      selectedLanguage: language,
      level: UserLevel.beginner,
      createdAt: DateTime.now(),
    );

    await _saveUserData();
    _isFirstTime = false;
    notifyListeners();
  }

  Future<void> addPoints(int points) async {
    if (_user != null) {
      _user = _user!.copyWith(totalPoints: _user!.totalPoints + points);
      await _saveUserData();
      _checkAchievements();
      notifyListeners();
    }
  }

  Future<void> updateStreak() async {
    if (_user != null) {
      _user = _user!.copyWith(streakDays: _user!.streakDays + 1);
      await _saveUserData();
      _checkAchievements();
      notifyListeners();
    }
  }

  Future<void> updateLevel(UserLevel newLevel) async {
    if (_user != null) {
      _user = _user!.copyWith(level: newLevel);
      await _saveUserData();
      notifyListeners();
    }
  }

  Future<void> _saveUserData() async {
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', json.encode(_user!.toJson()));
    }
  }

  void _initializeAchievements() {
    _achievements = [
      Achievement(
        id: 'first_lesson',
        title: 'First Steps',
        description: 'Complete your first lesson',
        iconPath: 'assets/images/achievement_first.png',
      ),
      Achievement(
        id: 'streak_7',
        title: 'Weekly Warrior',
        description: 'Maintain a 7-day streak',
        iconPath: 'assets/images/achievement_streak.png',
      ),
      Achievement(
        id: 'points_100',
        title: 'Century Club',
        description: 'Earn 100 points',
        iconPath: 'assets/images/achievement_points.png',
      ),
      Achievement(
        id: 'level_up',
        title: 'Level Up',
        description: 'Reach intermediate level',
        iconPath: 'assets/images/achievement_level.png',
      ),
    ];
  }

  void _checkAchievements() {
    if (_user == null) return;

    for (int i = 0; i < _achievements.length; i++) {
      if (!_achievements[i].isUnlocked) {
        bool shouldUnlock = false;

        switch (_achievements[i].id) {
          case 'first_lesson':
            shouldUnlock = _user!.totalPoints > 0;
            break;
          case 'streak_7':
            shouldUnlock = _user!.streakDays >= 7;
            break;
          case 'points_100':
            shouldUnlock = _user!.totalPoints >= 100;
            break;
          case 'level_up':
            shouldUnlock = _user!.level != UserLevel.beginner;
            break;
        }

        if (shouldUnlock) {
          _achievements[i] = _achievements[i].copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
        }
      }
    }
  }

  List<Achievement> getUnlockedAchievements() {
    return _achievements.where((achievement) => achievement.isUnlocked).toList();
  }
}