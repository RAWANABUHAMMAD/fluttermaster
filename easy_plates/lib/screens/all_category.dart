import 'package:flutter/material.dart';
import 'package:easy_plates/models/product.dart';
import 'package:easy_plates/models/category.dart';
import 'package:easy_plates/services/product_services.dart';
import 'package:easy_plates/screens/detail_recipe.dart';

class AllCategory extends StatefulWidget {
  final Category category;

  const AllCategory({super.key, required this.category});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture =
        ProductService.fetchProductsByCategory(widget.category.id.toString());
  }

  bool checkUserLoggedIn() {
    return false; // لاحقاً غيرها حسب حالة تسجيل الدخول
  }

  String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    const baseUrl = 'http://10.0.2.2:8000'; // غيّرها حسب سيرفرك
    return '$baseUrl/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          final products = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductItem(products[index], context);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductItem(Product product, BuildContext context) {
    final imageUrl = getFullImageUrl(product.image);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Ingredients
                    Text(
                      "Ingredients: ${product.ingredients.join(', ')}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Price and Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "JD${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailRecipe(product: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.shopping_cart),
                              onPressed: () {
                                if (!checkUserLoggedIn()) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Login Required'),
                                        content: const Text(
                                            'Please log in to add products to your cart.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Redirecting to login page..."),
                                                ),
                                              );
                                              // Navigator.of(context).pushNamed('/login');
                                            },
                                            child: const Text('Login'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("${product.name} added to cart!"),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
