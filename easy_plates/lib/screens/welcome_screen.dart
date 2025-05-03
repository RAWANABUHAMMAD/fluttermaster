import 'package:flutter/material.dart';
import 'package:easy_plates/screens/login_screen.dart';
import 'package:easy_plates/screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية
          Image.asset(
            'assets/images/welcome.jpg',
            fit: BoxFit.cover,
          ),

          // المحتوى
          Column(
            children: [
              const SizedBox(height: 200), // لرفع النص شوي
              const Text(
                'Easy Plates',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 200), // رفع الأزرار للأسفل شوي
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  style: _buttonStyle(),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()));
                  },
                  style: _buttonStyle(),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
