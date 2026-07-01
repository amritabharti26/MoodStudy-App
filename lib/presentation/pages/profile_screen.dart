import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/focus_controller.dart';
import '../controllers/mood_controller.dart';
import 'home_screen.dart';
import 'focus_screen.dart';
import 'analytics_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final MoodController controller = Get.find<MoodController>();
  final FocusController focusController = Get.find<FocusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        backgroundColor: Colors.white70,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.black, size: 32),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("images/dp.png"),
                    ),

                    Text(
                      "Amrita Bharti",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[100],
                        foregroundColor: Colors.deepPurple,
                        elevation: 2,
                      ),
                      child: Text(
                        "Flutter Developer",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Keep learning, keep growing!",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 8),

                    // Card 1
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.access_time_sharp,
                                color: Colors.green,
                                size: 35,
                              ),
                              title: Text(
                                "Total Study Hours",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: FutureBuilder<String>(
                                future: focusController.getTotalFocusTime(),
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data ?? "0 min",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  );
                                },
                              ),
                            ),

                            Divider(),

                            ListTile(
                              leading: Icon(
                                Icons.stream_outlined,
                                color: Colors.pink,
                                size: 35,
                              ),
                              title: Text(
                                "Total Focus Sessions",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: FutureBuilder<int>(
                                future: focusController.getTotalSessions(),
                                builder: (context, snapshot) {
                                  return Text(
                                    "${snapshot.data ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  );
                                },
                              ),
                            ),

                            Divider(),

                            ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 35,
                              ),
                              title: const Text(
                                "Completed Sessions",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),

                              subtitle: FutureBuilder<int>(
                                future: focusController.getCompletedSessions(),
                                builder: (context, snapshot) {
                                  return Text(
                                    "${snapshot.data ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                    ),
                                  );
                                },
                              ),
                            ),

                            Divider(),

                            ListTile(
                              leading: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.purple,
                                size: 35,
                              ),
                              title: Text(
                                "Most Used Mood",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                controller.mostUsedMood,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 6),

                    // Card 2
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                onPressed: () {},
                                style: IconButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.black12,
                                  foregroundColor: Colors.black,
                                ),
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                              title: Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),

                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            ),

                            ListTile(
                              leading: IconButton(
                                onPressed: () {},
                                style: IconButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.black12,
                                  foregroundColor: Colors.black,
                                ),
                                icon: Icon(
                                  Icons.notifications_none,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),

                              title: Text(
                                "Notifications",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            ),

                            ListTile(
                              leading: IconButton(
                                onPressed: () {},
                                style: IconButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.black12,
                                  foregroundColor: Colors.black,
                                ),
                                icon: Icon(Icons.dark_mode_outlined, size: 32),
                              ),
                              title: Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                iconSize: 38,
                                icon: Icon(
                                  Icons.toggle_on,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),

                            ListTile(
                              leading: IconButton(
                                onPressed: () {},
                                style: IconButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.pink.shade100,
                                  foregroundColor: Colors.red.shade900,
                                ),
                                icon: Icon(Icons.logout_outlined),
                              ),
                              title: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
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
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          }

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
