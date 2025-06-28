import '../models/models.dart';

class LessonService {
  List<Lesson> getAllLessons() {
    return [
      // Beginner Lessons
      Lesson(
        id: 'greetings_basic',
        title: 'Basic Greetings',
        description: 'Learn essential greetings and polite expressions',
        category: LessonCategory.greetings,
        requiredLevel: UserLevel.beginner,
        pointsReward: 15,
        vocabulary: [
          Vocabulary(
            id: 'hello',
            word: 'Hello',
            translation: 'Hola',
            pronunciation: 'OH-lah',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'goodbye',
            word: 'Goodbye',
            translation: 'Adiós',
            pronunciation: 'ah-DYOHS',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'please',
            word: 'Please',
            translation: 'Por favor',
            pronunciation: 'por fah-VOR',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'thankyou',
            word: 'Thank you',
            translation: 'Gracias',
            pronunciation: 'GRAH-see-ahs',
            language: 'Spanish',
          ),
        ],
      ),
      
      Lesson(
        id: 'numbers_1_10',
        title: 'Numbers 1-10',
        description: 'Master the first ten numbers',
        category: LessonCategory.numbers,
        requiredLevel: UserLevel.beginner,
        pointsReward: 12,
        vocabulary: [
          Vocabulary(
            id: 'one',
            word: 'One',
            translation: 'Uno',
            pronunciation: 'OO-noh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'two',
            word: 'Two',
            translation: 'Dos',
            pronunciation: 'dohs',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'three',
            word: 'Three',
            translation: 'Tres',
            pronunciation: 'trehs',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'four',
            word: 'Four',
            translation: 'Cuatro',
            pronunciation: 'KWAH-troh',
            language: 'Spanish',
          ),
        ],
      ),

      Lesson(
        id: 'colors_basic',
        title: 'Basic Colors',
        description: 'Learn essential color names',
        category: LessonCategory.colors,
        requiredLevel: UserLevel.beginner,
        pointsReward: 12,
        vocabulary: [
          Vocabulary(
            id: 'red',
            word: 'Red',
            translation: 'Rojo',
            pronunciation: 'ROH-hoh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'blue',
            word: 'Blue',
            translation: 'Azul',
            pronunciation: 'ah-SOOL',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'green',
            word: 'Green',
            translation: 'Verde',
            pronunciation: 'VER-deh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'yellow',
            word: 'Yellow',
            translation: 'Amarillo',
            pronunciation: 'ah-mah-REE-yoh',
            language: 'Spanish',
          ),
        ],
      ),

      // Intermediate Lessons
      Lesson(
        id: 'family_members',
        title: 'Family Members',
        description: 'Learn to talk about your family',
        category: LessonCategory.family,
        requiredLevel: UserLevel.intermediate,
        pointsReward: 18,
        vocabulary: [
          Vocabulary(
            id: 'mother',
            word: 'Mother',
            translation: 'Madre',
            pronunciation: 'MAH-dreh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'father',
            word: 'Father',
            translation: 'Padre',
            pronunciation: 'PAH-dreh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'brother',
            word: 'Brother',
            translation: 'Hermano',
            pronunciation: 'er-MAH-noh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'sister',
            word: 'Sister',
            translation: 'Hermana',
            pronunciation: 'er-MAH-nah',
            language: 'Spanish',
          ),
        ],
      ),

      Lesson(
        id: 'travel_essentials',
        title: 'Travel Essentials',
        description: 'Essential phrases for traveling',
        category: LessonCategory.travel,
        requiredLevel: UserLevel.intermediate,
        pointsReward: 20,
        vocabulary: [
          Vocabulary(
            id: 'airport',
            word: 'Airport',
            translation: 'Aeropuerto',
            pronunciation: 'ah-eh-roh-PWER-toh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'hotel',
            word: 'Hotel',
            translation: 'Hotel',
            pronunciation: 'oh-TEHL',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'restaurant',
            word: 'Restaurant',
            translation: 'Restaurante',
            pronunciation: 'res-tow-RAHN-teh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'taxi',
            word: 'Taxi',
            translation: 'Taxi',
            pronunciation: 'TAHK-see',
            language: 'Spanish',
          ),
        ],
      ),

      // Advanced Lessons
      Lesson(
        id: 'business_meeting',
        title: 'Business Meetings',
        description: 'Professional vocabulary for meetings',
        category: LessonCategory.business,
        requiredLevel: UserLevel.advanced,
        pointsReward: 25,
        vocabulary: [
          Vocabulary(
            id: 'meeting',
            word: 'Meeting',
            translation: 'Reunión',
            pronunciation: 'reh-oo-NYOHN',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'presentation',
            word: 'Presentation',
            translation: 'Presentación',
            pronunciation: 'preh-sen-tah-SYOHN',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'contract',
            word: 'Contract',
            translation: 'Contrato',
            pronunciation: 'kon-TRAH-toh',
            language: 'Spanish',
          ),
          Vocabulary(
            id: 'deadline',
            word: 'Deadline',
            translation: 'Fecha límite',
            pronunciation: 'FEH-chah LEE-mee-teh',
            language: 'Spanish',
          ),
        ],
      ),
    ];
  }

  List<PracticeExercise> generateExercisesForLesson(Lesson lesson) {
    List<PracticeExercise> exercises = [];
    
    // Generate multiple choice exercises for each vocabulary word
    for (int i = 0; i < lesson.vocabulary.length; i++) {
      final vocab = lesson.vocabulary[i];
      
      // Translation exercise
      exercises.add(PracticeExercise(
        id: 'translation_${vocab.id}',
        question: 'What is "${vocab.word}" in ${vocab.language}?',
        options: _generateOptions(vocab.translation, lesson.vocabulary),
        correctAnswer: vocab.translation,
        type: ExerciseType.multipleChoice,
      ));
      
      // Reverse translation exercise
      exercises.add(PracticeExercise(
        id: 'reverse_${vocab.id}',
        question: 'What does "${vocab.translation}" mean in English?',
        options: _generateReverseOptions(vocab.word, lesson.vocabulary),
        correctAnswer: vocab.word,
        type: ExerciseType.multipleChoice,
      ));
    }
    
    // Shuffle exercises for variety
    exercises.shuffle();
    
    // Return first 6 exercises to keep lessons manageable
    return exercises.take(6).toList();
  }

  List<String> _generateOptions(String correctAnswer, List<Vocabulary> vocabulary) {
    List<String> options = [correctAnswer];
    
    // Add other vocabulary translations as wrong options
    for (var vocab in vocabulary) {
      if (vocab.translation != correctAnswer && options.length < 4) {
        options.add(vocab.translation);
      }
    }
    
    // If we need more options, add some common wrong answers
    if (options.length < 4) {
      List<String> commonOptions = ['Casa', 'Agua', 'Tiempo', 'Persona', 'Día'];
      for (String option in commonOptions) {
        if (!options.contains(option) && options.length < 4) {
          options.add(option);
        }
      }
    }
    
    options.shuffle();
    return options;
  }

  List<String> _generateReverseOptions(String correctAnswer, List<Vocabulary> vocabulary) {
    List<String> options = [correctAnswer];
    
    // Add other vocabulary words as wrong options
    for (var vocab in vocabulary) {
      if (vocab.word != correctAnswer && options.length < 4) {
        options.add(vocab.word);
      }
    }
    
    // If we need more options, add some common wrong answers
    if (options.length < 4) {
      List<String> commonOptions = ['House', 'Water', 'Time', 'Person', 'Day'];
      for (String option in commonOptions) {
        if (!options.contains(option) && options.length < 4) {
          options.add(option);
        }
      }
    }
    
    options.shuffle();
    return options;
  }
}