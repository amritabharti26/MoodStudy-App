import 'package:flutter/material.dart';
import 'package:mood_study_app/presentation/pages/home_screen.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1FF),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.png", height: 215),

              SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mood",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),

                  SizedBox(width: 10),

                  Text(
                    "Study",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8),

              Text(
                "Study Smarter,\n Based on Your Mood",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 25),

              Image.asset("images/splash1.png", height: 180),

              SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: ElevatedButton(
                  onPressed: () {

                    if(FirebaseAuth.instance.currentUser != null) {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomeScreen(),
                        ),
                      );
                    }
                    else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    }




                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
