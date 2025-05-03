import 'package:flutter/material.dart';
import 'package:easy_plates/screens/all_category.dart';
import 'package:easy_plates/models/category.dart';
import 'package:easy_plates/services/category_services.dart'; // تأكد من المسار الصحيح

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Category> _categories = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
  try {
    final categories = await CategoryService.fetchCategories();
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  } catch (e) {
    print("Error loading categories: $e");
    setState(() {
      _isLoading = false;
    });
  }
}

  String getCategoryImage(String name) {
  switch (name.toLowerCase().trim()) {
    case 'appitizers':
      return 'assets/images/Apptizers2.jpg';
    case 'main dish':
      return 'assets/images/main_dish.jpg'; 
    case 'desserts':
      return 'assets/images/Desserts.jpg';
    default:
      return 'assets/images/default.jpg';
  }
}


  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCategory(category: category),
                    ),
                  );
                },
                child: Container(
                  width: 105,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            getCategoryImage(category.name),
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => const Icon(Icons.fastfood),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
