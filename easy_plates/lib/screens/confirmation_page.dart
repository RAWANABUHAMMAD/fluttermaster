import 'package:flutter/material.dart';
import 'package:easy_plates/screens/home_screen.dart';


class ConfirmationPage extends StatelessWidget {
  final String name;
  final String address;
  final String phone;

  const ConfirmationPage({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Confirmation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Thank you for your order!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your order has been placed successfully. You will receive an email confirmation shortly.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              "Shipping Information:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Name: $name"),
            Text("Address: $address"),
            Text("Phone: $phone"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => const HomeScreen()),
  (route) => false,
);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Back to Home",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
