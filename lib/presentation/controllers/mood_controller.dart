import 'package:get/get.dart';

import '../../domain/entities/mood_entity.dart';
import '../../domain/usecases/add_mood.dart';
import '../../domain/usecases/delete_mood.dart';
import '../../domain/usecases/get_mood.dart';
import 'focus_controller.dart';

class MoodController extends GetxController {
  final AddMood addMoodUseCase;
  final GetMood getMoodUseCase;
  final DeleteMood deleteMoodUseCase;

  MoodController({
    required this.addMoodUseCase,
    required this.getMoodUseCase,
    required this.deleteMoodUseCase,
  });

  final selectedMood = "".obs;
  final moodHistory = <MoodEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllMoods();
  }

  Future<void> saveMood() async {
    if (selectedMood.value.isEmpty) return;

    final focusController = Get.find<FocusController>();

    focusController.setTimerByMood(selectedMood.value);

    final mood = MoodEntity(
      mood: selectedMood.value,
      recommendation: getStudyMethod(),
      focusTime: focusController.focusTime,
      date: DateTime.now().toIso8601String(),
    );

    await addMoodUseCase(mood);

    await getAllMoods();
  }

  Future<void> getAllMoods() async {
    moodHistory.value = await getMoodUseCase();
  }

  Future<void> deleteMood(int id) async {
    await deleteMoodUseCase(id);
    await getAllMoods();
  }

  int get totalSessions => moodHistory.length;

  String get mostUsedMood {
    if (moodHistory.isEmpty) return "No Data";

    final Map<String, int> moodCount = {};

    for (final mood in moodHistory) {
      moodCount[mood.mood] = (moodCount[mood.mood] ?? 0) + 1;
    }

    String mostMood = moodCount.keys.first;

    moodCount.forEach((key, value) {
      if (value > moodCount[mostMood]!) {
        mostMood = key;
      }
    });

    return mostMood;
  }

  int getMoodCount(String mood) {
    return moodHistory.where((e) => e.mood == mood).length;
  }

  double getMoodPercentage(String mood) {
    if (moodHistory.isEmpty) return 0;

    int count = moodHistory.where((e) => e.mood == mood).length;

    return (count / moodHistory.length) * 100;
  }

  String getStudyMethod() {
    switch (selectedMood.value) {
      case "Happy":
        return "90 Min Deep Work";

      case "Motivated":
        return "120 Min Goal Session";

      case "Stressed":
        return "Pomodoro 20-5";

      case "Sad":
        return "Light Revision Session";

      case "Distracted":
        return "25 Min Focus Sprint";

      case "Lazy":
        return "10 Min Start Rule";

      default:
        return "General Study Session";
    }
  }

  String getMusicRecommendation() {
    switch (selectedMood.value) {
      case "Happy":
        return "Lo-Fi Beats";

      case "Motivated":
        return "Instrumental Focus";

      case "Stressed":
        return "Calm Piano";

      case "Sad":
        return "Nature Sounds";

      case "Distracted":
        return "White Noise";

      case "Lazy":
        return "Energetic Instrumental";

      default:
        return "Focus Music";
    }
  }

  String getStudyTip() {
    switch (selectedMood.value) {
      case "Happy":
        return "Use your energy for difficult topics";

      case "Motivated":
        return "Finish your highest priority task";

      case "Stressed":
        return "Take deep breaths every 20 minutes";

      case "Sad":
        return "Start small and build momentum";

      case "Distracted":
        return "Keep your phone away";

      case "Lazy":
        return "Study for just 10 minutes first";

      default:
        return "Stay consistent";
    }
  }
}
