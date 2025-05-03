import 'package:flutter/material.dart';
import 'package:easy_plates/data/dummy_data.dart';
import 'package:easy_plates/screens/detail_recipe.dart';


class AllMealsScreen extends StatelessWidget {
  const AllMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allProducts = dummyProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Meals'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          final product = allProducts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(product.image, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(product.name),
              subtitle: Text("JD${product.price.toStringAsFixed(2)}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetailRecipe(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
