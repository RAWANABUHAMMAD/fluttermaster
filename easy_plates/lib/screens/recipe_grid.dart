import 'package:flutter/material.dart';
import 'package:easy_plates/data/dummy_data.dart';
import 'package:easy_plates/models/product.dart'; // Ensure this is the correct path to the Product class

class RecipeGrid extends StatelessWidget {
  const RecipeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات حسب الفئة
    List<Product> appetizerProducts = dummyProducts
        .where((product) => product.categoryId == 'c1')
        .take(2) // أخذ أول منتجين من فئة Appetizers
        .toList();

    List<Product> mainCourseProducts = dummyProducts
        .where((product) => product.categoryId == 'c2')
        .take(2) // أخذ أول منتجين من فئة Main dishes
        .toList();

    // دمج المنتجات المفلترة
    List<Product> displayedProducts = [...appetizerProducts, ...mainCourseProducts];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = displayedProducts[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meal Image
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        product.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Name, price, and cart icon
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Meal Name
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Price and cart icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price
                              Text(
                                'JD${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              // Cart Icon
                              InkWell(
                                onTap: () {
                                  _showLoginAlert(context);
                                },
                                child: const Icon(
                                  Icons.shopping_cart,
                                  size: 22,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Show login alert
  void _showLoginAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alert'),
        content: const Text('You must log in first to add items to the cart.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
