import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mood_controller.dart';
import '../controllers/focus_controller.dart';

class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen> {
  final MoodController controller = Get.find<MoodController>();
  final FocusController focusController = Get.find<FocusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mood History")),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood History
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Mood History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Obx(() {
              if (controller.moodHistory.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.mood, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "No Mood History Yet",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Select a mood to start your study session.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.moodHistory.length,
                itemBuilder: (context, index) {
                  final mood = controller.moodHistory[index];

                  return ListTile(
                    title: Text(mood.mood),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mood.recommendation),
                        Text("Focus Time: ${mood.focusTime}"),
                        Text(mood.date),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.deleteMood(mood.id!);
                      },
                    ),
                  );
                },
              );
            }),

            Divider(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Focus Session History",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            FutureBuilder(
              future: focusController.getAllSessions(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final sessions = snapshot.data!;

                if (sessions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(Icons.timer_off, size: 60, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "No Focus Sessions Yet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Complete a focus session to view your history.",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];

                    return ListTile(
                      leading: Icon(Icons.timer),

                      title: Text(session.mood),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Allocated: ${session.allocatedSeconds}s"),
                          Text("Studied: ${session.studiedSeconds}s"),
                          Text("Status: ${session.status}"),
                          Text(session.date),
                        ],
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await focusController.deleteSession(session.id!);

                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
