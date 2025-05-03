import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_plates/models/product.dart';

class ProductService {
  // رابط الـ API عبر emulator
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // دالة تحميل جميع المنتجات
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes'));

  
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
static Future<List<Product>> fetchProductsByCategory(String categoryId) async {
  final response = await http.get(Uri.parse('$baseUrl/recipes?category_id=$categoryId'));

  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products by category');
  }
}


}
