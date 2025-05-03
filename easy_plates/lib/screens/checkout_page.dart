import 'package:flutter/material.dart';
import 'package:easy_plates/providers/cart_provider.dart';
import 'package:easy_plates/screens/confirmation_page.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: cartProvider.items.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 20),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      itemCount: cartProvider.items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartProvider.items[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Image.asset(
                              cartItem.product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(cartItem.product.name),
                            subtitle: Text('JD${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
                            trailing: Text('x${cartItem.quantity}'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Total: JD${cartProvider.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter Shipping Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order Confirmed!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmationPage(
                              name: nameController.text,
                              address: addressController.text,
                              phone: phoneController.text,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "Confirm Order",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
