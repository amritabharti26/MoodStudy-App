import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/focus_controller.dart';

import 'home_screen.dart';
import 'analytics_screen.dart';
import 'profile_screen.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  final FocusController controller = Get.find<FocusController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await controller.pauseTimer();
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //Heading
              ListTile(
                title: Text(
                  "Focus Timer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                subtitle: Text(
                  "Stay focused, Achieve more!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),

              SizedBox(height: 15),

              // timer
              Container(
                width: 200,
                height: 200,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: BoxBorder.all(color: Colors.deepPurple, width: 10),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      color: Colors.deepPurple.withValues(alpha: 0.15),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.formattedTime,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 0.5),

                    Text(
                      "Focus Time",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              //mode
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  "🍅 Pomodoro Mode",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              SizedBox(height: 15),

              //Start button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 27),
                      SizedBox(width: 3),
                      Text("Start", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              //pause Reset button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.pauseTimer,
                      child: Row(
                        children: [
                          Icon(Icons.pause),
                          SizedBox(width: 5),
                          Text("Pause"),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.resetTimer,
                      child: Row(
                        children: [
                          Icon(Icons.restart_alt),
                          SizedBox(width: 5),
                          Text("Reset"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),

              //Progress Bar
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      FutureBuilder<List<dynamic>>(
                        future: Future.wait([
                          controller.getCompletedSessions(),
                          controller.getTotalSessions(),
                        ]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text("0 / 0 Sessions Completed");
                          }

                          final completed = snapshot.data![0] as int;
                          final total = snapshot.data![1] as int;

                          return Text("$completed / $total Sessions Completed");
                        },
                      ),

                      SizedBox(height: 4),

                      //bug for saving exact time hr user studied
                      Obx(
                        () => LinearProgressIndicator(
                          value:
                              (controller.initialSeconds.value -
                                  controller.seconds.value) /
                              controller.initialSeconds.value,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple.shade100,
                        ),
                      ),
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
        currentIndex: 1,

        selectedItemColor: Colors.deepPurple,

        onTap: (index) async {
          if (index == 0) {
            await controller.pauseTimer();
            Get.off(() => HomeScreen());
          }

          if (index == 2) {
            await controller.pauseTimer();
            Get.off(() => AnalyticsScreen());
          }

          if (index == 3) {
            await controller.pauseTimer();
            Get.off(() => ProfileScreen());
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
