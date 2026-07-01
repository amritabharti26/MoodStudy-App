import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mood_controller.dart';
import 'recommendation_screen.dart';
import 'focus_screen.dart';
import 'analytics_screen.dart';
import 'mood_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MoodController controller = Get.find<MoodController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Amrita!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              Text(
                "How are you feeling today?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  moodCard(
                    iconBgColor: Colors.yellow.shade600,
                    cardColor: Colors.orange.shade100,
                    title: "Happy",
                    imagePath: "images/happy.png",

                    onTap: () {
                      controller.selectedMood.value = "Happy";
                    },
                  ),
                  moodCard(
                    iconBgColor: Colors.orange.shade100,
                    cardColor: Colors.orange.shade300,
                    title: "Motivated",
                    imagePath: "images/motivated.png",

                    onTap: () {
                      controller.selectedMood.value = "Motivated";
                    },
                  ),

                  moodCard(
                    iconBgColor: Colors.indigo.shade50,
                    cardColor: Colors.indigo.shade300,
                    title: "stressed",
                    imagePath: "images/stressed.png",

                    onTap: () {
                      controller.selectedMood.value = "Stressed";
                    },
                  ),

                  moodCard(
                    iconBgColor: Colors.blueGrey.shade50,
                    cardColor: Colors.blueGrey.shade300,
                    title: "Sad",
                    imagePath: "images/sad.png",

                    onTap: () {
                      controller.selectedMood.value = "Sad";
                    },
                  ),
                  moodCard(
                    iconBgColor: Colors.brown.shade100,
                    cardColor: Colors.brown.shade50,
                    title: "Distracted",
                    imagePath: "images/distracted.png",

                    onTap: () {
                      controller.selectedMood.value = "Distracted";
                    },
                  ),
                  moodCard(
                    iconBgColor: Colors.purple.shade200,
                    cardColor: Colors.purple.shade100,
                    title: "Lazy",
                    imagePath: "images/lazy.png",

                    onTap: () {
                      controller.selectedMood.value = "Lazy";
                    },
                  ),
                ],
              ),

              SizedBox(height: 15),

              Obx(
                () => Text(
                  "Selected Mood: ${controller.selectedMood.value}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),

              Obx(() => Text("Saved Moods: ${controller.moodHistory.length}")),

              ElevatedButton(
                onPressed: () async {
                  print("Continue pressed");

                  try {
                    await controller.saveMood();
                    print("Mood saved");

                    Get.to(() => RecommendationScreen());
                  } catch (e, s) {
                    print(e);
                    print(s);

                    Get.snackbar("Error", e.toString());
                  }
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
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

              ElevatedButton(
                onPressed: () {
                  Get.to(() => MoodHistoryScreen());
                },

                child: const Text("View History"),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,

        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FocusScreen()),
            );
          }

          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AnalyticsScreen()),
            );
          }

          if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            );
          }
        },

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
  required Color iconBgColor,
  required Color cardColor,
  required String title,
  required String imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          width: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(imagePath, height: 60, width: 60),
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
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
