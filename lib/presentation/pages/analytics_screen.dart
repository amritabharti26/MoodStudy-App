import 'package:flutter/material.dart';
import '../controllers/focus_controller.dart';
import 'home_screen.dart';
import 'focus_screen.dart';
import 'profile_screen.dart';
import 'package:get/get.dart';
import '../controllers/mood_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final MoodController moodController = Get.find<MoodController>();
  final FocusController focusController = Get.find<FocusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F4FB),
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month)),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(
                "Analytics",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Track your productivity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ),

            SizedBox(height: 12),

            // pending work
            Column(
              children: [
                // First Row
                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<String>(
                        future: focusController.getTotalFocusTime(),
                        builder: (context, snapshot) {
                          return analyticsCard(
                            icon: Icons.access_time_outlined,
                            iconColor: Colors.indigo,
                            cardColor: Colors.indigo.shade50,
                            title: "Total Focus Time",
                            value: snapshot.data ?? "0 min",
                            subtitle: "Overall",
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: FutureBuilder<int>(
                        future: focusController.getCompletedSessions(),
                        builder: (context, snapshot) {
                          return analyticsCard(
                            icon: Icons.check_circle,
                            iconColor: Colors.green,
                            cardColor: Colors.green.shade50,
                            title: "Completed",
                            value: "${snapshot.data ?? 0}",
                            subtitle: "Sessions",
                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Second Row
                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<int>(
                        future: focusController.getPartialSessions(),
                        builder: (context, snapshot) {
                          return analyticsCard(
                            icon: Icons.pause_circle,
                            iconColor: Colors.orange,
                            cardColor: Colors.orange.shade50,
                            title: "Partial",
                            value: "${snapshot.data ?? 0}",
                            subtitle: "Sessions",
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 12),

                    Expanded(
                      child: Obx(
                        () => analyticsCard(
                          icon: Icons.emoji_emotions_outlined,
                          iconColor: Colors.purple,
                          cardColor: Colors.purple.shade50,
                          title: "Most Used Mood",
                          value: moodController.mostUsedMood,
                          subtitle: "",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //BarChart for user studied focus time in week
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Focus Time This Week",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // BarChart
                      FutureBuilder<List<double>>(
                        future: focusController.getWeeklyFocusData(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              height: 300,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final data = snapshot.data!;

                          return SizedBox(
                            height: 300,
                            child: BarChart(
                              BarChartData(
                                maxY: 120,

                                gridData: FlGridData(
                                  show: true,
                                  drawHorizontalLine: true,
                                  drawVerticalLine: false,
                                ),

                                borderData: FlBorderData(show: false),

                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),

                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),

                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 42,
                                    ),
                                  ),

                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 35,
                                      getTitlesWidget: (value, meta) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return const Text("Mon");
                                          case 1:
                                            return const Text("Tue");
                                          case 2:
                                            return const Text("Wed");
                                          case 3:
                                            return const Text("Thu");
                                          case 4:
                                            return const Text("Fri");
                                          case 5:
                                            return const Text("Sat");
                                          case 6:
                                            return const Text("Sun");
                                        }

                                        return const Text("");
                                      },
                                    ),
                                  ),
                                ),

                                barGroups: List.generate(7, (index) {
                                  return BarChartGroupData(
                                    x: index,
                                    barRods: [
                                      BarChartRodData(
                                        toY: data[index],
                                        width: 20,
                                        color: Colors.indigo.shade600,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // PieChart for mood %
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mood Distribution",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 250,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 3,
                            centerSpaceRadius: 45,
                            sections: [
                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Happy")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Happy").toStringAsFixed(0)}%",
                                color: Colors.green,
                                radius: 70,
                              ),

                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Motivated")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Motivated").toStringAsFixed(0)}%",
                                color: Colors.blue,
                                radius: 70,
                              ),

                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Stressed")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Stressed").toStringAsFixed(0)}%",
                                color: Colors.orange,
                                radius: 70,
                              ),
                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Lazy")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Lazy").toStringAsFixed(0)}%",

                                color: Colors.purple,
                                radius: 70,
                              ),
                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Distracted")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Distracted").toStringAsFixed(0)}%",
                                color: Colors.yellowAccent.shade700,
                                radius: 70,
                              ),
                              PieChartSectionData(
                                value: moodController
                                    .getMoodCount("Sad")
                                    .toDouble(),
                                title:
                                    "${moodController.getMoodPercentage("Sad").toStringAsFixed(0)}%",
                                color: Colors.pinkAccent.shade700,
                                radius: 70,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Represent color Assigned to mood
            Wrap(
              spacing: 25,
              runSpacing: 10,
              children: [
                buildLegend(Colors.green, "Happy"),
                buildLegend(Colors.blue, "Motivated"),
                buildLegend(Colors.orange, "Stressed"),
                buildLegend(Colors.purple, "Lazy"),
                buildLegend(Colors.yellowAccent.shade700, "Distracted"),
                buildLegend(Colors.pinkAccent.shade700, "Sad"),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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

Widget analyticsCard({
  required IconData icon,
  required Color iconColor,
  required Color cardColor,
  required String title,
  required String value,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 200,
      child: Card(
        color: cardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 32),

              SizedBox(height: 12),

              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 8),

              Text(
                value,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildLegend(Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(text),
    ],
  );
}
