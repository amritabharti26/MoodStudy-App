import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_study_app/services/firebase_services/auth_service.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService authService = AuthService();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),

              const SizedBox(height: 10),

              const Text(
                "Create Account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                "Sign up to get started with\nMood Study 💜",
                style: TextStyle(fontSize: 17, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 35),

              buildTextField(
                controller: nameController,
                label: "Full Name",
                hint: "Enter your full name",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: emailController,
                label: "Email Address",
                hint: "Enter your email",
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: passwordController,
                label: "Password",
                hint: "Create password",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              buildTextField(
                controller: confirmPasswordController,
                label: "Confirm Password",
                hint: "Confirm password",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await authService.signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (!context.mounted) return;


                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account created successfully"),
                        ),
                      );

                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } on FirebaseAuthException catch (e) {
                      String message;

                      switch (e.code) {
                        case "email-already-in-use":
                          message = "Email already registered.";
                          break;

                        case "weak-password":
                          message = "Password must be at least 6 characters.";
                          break;

                        case "invalid-email":
                          message = "Invalid email.";
                          break;

                        default:
                          message = e.message ?? "Signup failed.";
                      }

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 25),

              socialButton(
                icon: Icons.g_mobiledata,
                text: "Continue with Google",

                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: obscureText
              ? const Icon(Icons.visibility_off_outlined)
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
      ),
    ],
  );
}

Widget socialButton({
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28),
      label: Text(text, style: const TextStyle(fontSize: 16)),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
