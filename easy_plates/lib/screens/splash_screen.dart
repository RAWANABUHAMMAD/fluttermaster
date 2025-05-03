import 'package:flutter/material.dart';
import 'package:easy_plates/screens/welcome_screen.dart';
 import 'package:flutter_svg/flutter_svg.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToWelcome();
  }

  Future<void> _navigateToWelcome() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // استخدام SVG بدلاً من PNG
            SvgPicture.asset(
              'assets/images/logo.svg', // تأكد من أن المسار مطابق للملف
              width: 250,
              height: 250,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), // اختياري
              placeholderBuilder: (BuildContext context) => const CircularProgressIndicator(), // أثناء التحميل
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}