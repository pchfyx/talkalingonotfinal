// User Model
class User {
  final String id;
  final String name;
  final String selectedLanguage;
  final UserLevel level;
  final int totalPoints;
  final int streakDays;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.selectedLanguage,
    required this.level,
    this.totalPoints = 0,
    this.streakDays = 0,
    required this.createdAt,
  });

  User copyWith({
    String? name,
    String? selectedLanguage,
    UserLevel? level,
    int? totalPoints,
    int? streakDays,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      level: level ?? this.level,
      totalPoints: totalPoints ?? this.totalPoints,
      streakDays: streakDays ?? this.streakDays,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'selectedLanguage': selectedLanguage,
      'level': level.toString(),
      'totalPoints': totalPoints,
      'streakDays': streakDays,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      selectedLanguage: json['selectedLanguage'],
      level: UserLevel.values.firstWhere(
        (e) => e.toString() == json['level'],
        orElse: () => UserLevel.beginner,
      ),
      totalPoints: json['totalPoints'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }
}

enum UserLevel { beginner, intermediate, advanced }

// Lesson Model
class Lesson {
  final String id;
  final String title;
  final String description;
  final LessonCategory category;
  final UserLevel requiredLevel;
  final List<Vocabulary> vocabulary;
  final int pointsReward;
  final bool isCompleted;
  final int? userScore;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.requiredLevel,
    required this.vocabulary,
    this.pointsReward = 10,
    this.isCompleted = false,
    this.userScore,
  });

  Lesson copyWith({
    bool? isCompleted,
    int? userScore,
  }) {
    return Lesson(
      id: id,
      title: title,
      description: description,
      category: category,
      requiredLevel: requiredLevel,
      vocabulary: vocabulary,
      pointsReward: pointsReward,
      isCompleted: isCompleted ?? this.isCompleted,
      userScore: userScore ?? this.userScore,
    );
  }
}

enum LessonCategory {
  greetings,
  numbers,
  colors,
  family,
  food,
  travel,
  business,
  emergencies,
}

// Vocabulary Model
class Vocabulary {
  final String id;
  final String word;
  final String translation;
  final String pronunciation;
  final String? audioPath;
  final String language;

  Vocabulary({
    required this.id,
    required this.word,
    required this.translation,
    required this.pronunciation,
    this.audioPath,
    required this.language,
  });
}

// Practice Exercise Model
class PracticeExercise {
  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final ExerciseType type;
  final String? audioPath;

  PracticeExercise({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.type,
    this.audioPath,
  });
}

enum ExerciseType {
  multipleChoice,
  translation,
  listening,
  speaking,
}

// Achievement Model
class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  Achievement copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      iconPath: iconPath,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}