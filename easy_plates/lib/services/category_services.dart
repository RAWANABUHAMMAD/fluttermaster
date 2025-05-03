import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_plates/models/category.dart';

class CategoryService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Emulator IP

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/category'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}

