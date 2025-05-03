import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_plates/screens/splash_screen.dart';
import 'package:easy_plates/providers/cart_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(), 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Easy Plates',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SplashScreen(), // Start with the splash screen
      ),
    );
  }
}
