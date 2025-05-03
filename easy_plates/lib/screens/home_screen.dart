import 'package:easy_plates/bars/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_plates/screens/category_list.dart';
import 'package:easy_plates/screens/recipe_grid.dart';
import 'package:easy_plates/screens/all_meals_screen.dart';
import 'package:easy_plates/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();


  final List<Widget> _pages = [
    _HomeContent(),
    const AllMealsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 ? _buildAppBar() : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for meals...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 70,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // الانتقال لصفحة السلة
          },
        ),
      ],
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'How Easy Plates Works',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStepCard(
                  stepNumber: 1,
                  imagePath: 'assets/images/step1.jpg',
                  description: 'Choose your meals',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStepCard(
                  stepNumber: 2,
                  imagePath: 'assets/images/step2.jpg',
                  description: 'Get your delivery',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStepCard(
                  stepNumber: 3,
                  imagePath: 'assets/images/step3.jpg',
                  description: 'Cook & Enjoy',
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 140, child: const CategoryList()),
          const SizedBox(height: 30),
          const Text(
            'Recommended Meals',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 500, child: const RecipeGrid()),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required int stepNumber,
    required String imagePath,
    required String description,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  '$stepNumber',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Colors.white70,
                    offset: Offset(0, 0),
                    blurRadius: 0,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}