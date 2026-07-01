import 'package:flutter/material.dart';
import '../controllers/focus_controller.dart';
import 'focus_screen.dart';
import 'package:get/get.dart';
import '../controllers/mood_controller.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({super.key});

  final MoodController controller = Get.find<MoodController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text(
                  "Your Mood",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                subtitle: Obx(
                  () => Text(
                    controller.selectedMood.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),

              Center(
                child: Text(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                  "Recommended Plan",
                ),
              ),

              SizedBox(height: 10),

              moodCard(
                icon: Icons.menu_book_outlined,
                iconColor: Colors.deepPurple,
                iconBgColor: Colors.deepPurple.shade100,
                title: "Study Method",
                methodValue: controller.getStudyMethod(),
                subtitle: "Focus in short sessions\n with 5 min break",
              ),

              moodCard(
                icon: Icons.music_note,
                iconColor: Colors.green.shade500,
                iconBgColor: Colors.green.shade100,
                title: "Music Recommendation",
                methodValue: controller.getMusicRecommendation(),
                subtitle: "Soothing music to relax\n your mind",
              ),

              moodCard(
                icon: Icons.lightbulb,
                iconColor: Colors.orange.shade400,
                iconBgColor: Colors.orange.shade100,
                title: "Study Tip",
                methodValue: controller.getStudyTip(),
                subtitle: "Stay hydrated and\n take short breaks",
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  final focusController = Get.find<FocusController>();

                  focusController.setTimerByMood(controller.selectedMood.value);

                  Get.to(() => FocusScreen());
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        "Start Focus Session",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward, size: 25),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,

        selectedItemColor: Colors.deepPurple,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Timer"),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Analytics",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}

Widget moodCard({
  required IconData icon,
  required Color iconColor,
  required Color iconBgColor,
  required String title,
  required String methodValue,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      width: double.infinity,

      child: Card(
        elevation: 10,
        color: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: iconColor),
              ),

              SizedBox(height: 12),

              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12),

              Text(
                methodValue,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 12),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
