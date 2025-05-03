import 'package:easy_plates/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Make sure the file path is correct

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = AuthService.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text(
                  user['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  user['email'] ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),

                Text(
                  user['phone'] ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                _buildProfileOption(
                  icon: Icons.shopping_bag,
                  title: 'My Orders',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () async {
                    await AuthService.logout();
                    if (!mounted) return;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  isLogout: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.green),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isLogout ? Colors.red : Colors.black,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}