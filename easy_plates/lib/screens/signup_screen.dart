import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_plates/screens/home_screen.dart';
import 'dart:convert';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    const String apiUrl = 'http://10.0.2.2:8000/api/custom-register';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'address': _addressController.text.trim(),
          'password': _passwordController.text,
          'password_confirmation': _confirmPasswordController.text,
        }),
      );

      final data = json.decode(response.body);

     if (response.statusCode == 200 && data['user'] != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Registration Successful')),
  );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()), // ✅ يذهب إلى صفحة Home
  );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
'Registration failed: ' +
    (data['message'] ?? (data['errors'] != null ? data['errors'].toString() : 'Unknown error')),
  ),
),

        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.black),
        border: const UnderlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset('assets/images/image1.jpeg', fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputField(
                            controller: _nameController,
                            hint: 'Full Name',
                            icon: Icons.person,
                            validator: (val) => val == null || val.isEmpty ? 'Enter your name' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            controller: _emailController,
                            hint: 'Email',
                            icon: Icons.email,
                            validator: (val) => val == null || !val.contains('@') ? 'Enter a valid email' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            controller: _phoneController,
                            hint: 'Phone',
                            icon: Icons.phone,
                            validator: (val) => val == null || val.isEmpty ? 'Enter phone number' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            controller: _addressController,
                            hint: 'Address',
                            icon: Icons.home,
                            validator: (val) => val == null || val.isEmpty ? 'Enter address' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock,
                            obscure: true,
                            validator: (val) => val != null && val.length >= 6 ? null : 'Min 6 characters',
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            controller: _confirmPasswordController,
                            hint: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: (val) => val == _passwordController.text ? null : 'Passwords do not match',
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _registerUser,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('Sign Up', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                                  );
                                },
                                child: const Text("Login"),
                              ),
                            ],
                          )
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
    );
  }
}
