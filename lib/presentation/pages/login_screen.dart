import 'package:flutter/material.dart';
import 'package:mood_study_app/services/firebase_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_study_app/presentation/pages/home_screen.dart';
import 'package:mood_study_app/presentation/pages/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Logo
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.indigo.shade100,
                child: const Icon(
                  Icons.lock_outline,
                  size: 50,
                  color: Colors.indigo,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Login to continue",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await authService.login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen(),
                        ),
                            (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      String message;

                      switch (e.code) {
                        case "invalid-email":
                          message = "please enter a valid email.";
                          break;
                        case "invalid-credential":
                          message = "Invalid email or password.";
                          break;

                        case "user-not-found":
                          message = "User not found.";
                          break;

                        case "wrong-password":
                          message = "Incorrect password.";
                          break;

                        default:
                          message = e.message ?? "Login failed.";
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    }

                    finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child:
                  isLoading
                      ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                      : const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 25),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.g_mobiledata, size: 30),
                label: const Text("Continue with Google"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
