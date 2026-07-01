import 'dart:async';
import 'package:get/get.dart';
import 'package:mood_study_app/domain/usecases/update_focus_session.dart';

import '../../domain/entities/focus_session_entity.dart';
import '../../domain/usecases/add_focus_session.dart';
import '../../domain/usecases/delete_focus_session.dart';
import '../../domain/usecases/get_focus_sessions.dart';

class FocusController extends GetxController {
  final AddFocusSession addFocusSession;
  final GetFocusSessions getFocusSessions;
  final UpdateFocusSession updateFocusSession;
  final DeleteFocusSession deleteFocusSession;

  FocusController({
    required this.addFocusSession,
    required this.getFocusSessions,
    required this.updateFocusSession,
    required this.deleteFocusSession,
  });

  final seconds = 1500.obs;
  final initialSeconds = 1500.obs;
  final currentMood = "".obs;

  final isRunning = false.obs;

  Timer? timer;

  int? currentSessionId;

  String get focusTime {
    int hours = seconds.value ~/ 3600;
    int minutes = (seconds.value % 3600) ~/ 60;

    if (hours > 0) {
      return "${hours}h ${minutes}m";
    }

    return "$minutes min";
  }

  String get studiedTime {
    final studied = initialSeconds.value - seconds.value;

    int hours = studied ~/ 3600;
    int minutes = (studied % 3600) ~/ 60;

    if (hours > 0) {
      return "${hours}h ${minutes}m";
    }

    return "$minutes min";
  }

  String get formattedTime {
    int minutes = seconds.value ~/ 60;
    int remainingSeconds = seconds.value % 60;

    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Future<String> getTotalFocusTime() async {
    final sessions = await getFocusSessions();

    int totalSeconds = 0;

    for (final session in sessions) {
      totalSeconds += session.studiedSeconds;
    }

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;

    if (hours > 0) {
      return "$hours h $minutes m";
    }

    return "$minutes min";
  }

  Future<int> getTotalSessions() async {
    final sessions = await getFocusSessions();
    return sessions.length;
  }

  Future<int> getCompletedSessions() async {
    final sessions = await getFocusSessions();

    return sessions.where((e) => e.status == "Completed").length;
  }

  Future<int> getPartialSessions() async {
    final sessions = await getFocusSessions();

    return sessions.where((e) => e.status == "Partial").length;
  }

  void setTimerByMood(String mood) {
    currentMood.value = mood;

    switch (mood) {
      case "Happy":
        seconds.value = 5400;
        initialSeconds.value = 5400;
        break;

      case "Motivated":
        seconds.value = 7200;
        initialSeconds.value = 7200;
        break;

      case "Stressed":
        seconds.value = 1500;
        initialSeconds.value = 1500;
        break;

      case "Sad":
        seconds.value = 1800;
        initialSeconds.value = 1800;
        break;

      case "Distracted":
        seconds.value = 1500;
        initialSeconds.value = 1500;
        break;

      case "Lazy":
        seconds.value = 600;
        initialSeconds.value = 600;
        break;

      default:
        seconds.value = 1500;
        initialSeconds.value = 1500;
        break;
    }
  }

  void startTimer() {
    if (timer != null && timer!.isActive) return;

    isRunning.value = true;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();

        isRunning.value = false;

        await saveFocusSession(status: "Completed");

        currentSessionId = null;
      }
    });
  }

  Future<void> pauseTimer() async {
    timer?.cancel();
    timer = null;
    isRunning.value = false;

    await saveFocusSession(status: "Partial");
  }

  void resetTimer() {
    timer?.cancel();
    timer = null;

    isRunning.value = false;

    currentSessionId = null;

    setTimerByMood(currentMood.value);
  }

  Future<void> saveFocusSession({required String status}) async {
    final studiedSeconds = initialSeconds.value - seconds.value;

    if (studiedSeconds <= 0) return;

    final session = FocusSessionEntity(
      id: currentSessionId,
      mood: currentMood.value,
      allocatedSeconds: initialSeconds.value,
      studiedSeconds: studiedSeconds,
      status: status,
      date: DateTime.now().toIso8601String(),
    );

    if (currentSessionId == null) {
      currentSessionId = await addFocusSession(session);
    } else {
      await updateFocusSession(session);
    }
  }

  Future<void> deleteSession(int id) async {
    await deleteFocusSession(id);
  }

  Future<List<FocusSessionEntity>> getAllSessions() async {
    return await getFocusSessions();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<List<double>> getWeeklyFocusData() async {
    final sessions = await getFocusSessions();

    List<double> weeklyData = List.filled(7, 0);

    for (final session in sessions) {
      final day = DateTime.parse(session.date).weekday;

      if (day >= 1 && day <= 7) {
        weeklyData[day - 1] += session.studiedSeconds / 60;
      }
    }

    return weeklyData;
  }
}
