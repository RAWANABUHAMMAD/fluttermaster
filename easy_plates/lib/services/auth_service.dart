import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// إرجاع عنوان السيرفر حسب المنصة
String getBaseUrl() {
  if (kIsWeb) {
    return 'http://127.0.0.1:8000'; // Web
  } else {
    return 'http://10.0.2.2:8000'; // Android Emulator
  }
}

class AuthService {
  /// تسجيل الدخول
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('${getBaseUrl()}/login');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // حفظ التوكن في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return data;
    } else {
      throw Exception('فشل تسجيل الدخول: ${response.body}');
    }
  }

  /// تسجيل حساب جديد
  static Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('${getBaseUrl()}/custom-register');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('فشل التسجيل: ${response.body}');
    }
  }

  /// جلب بيانات المستخدم
  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token غير موجود');

    final response = await http.get(
      Uri.parse('${getBaseUrl()}/api/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('فشل في جلب بيانات المستخدم');
    }
  }

  /// تسجيل الخروج
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // حذف التوكن

    // إذا حبيت تعمل Logout API من السيرفر، ممكن تضيف هنا:
    // await http.post(...);
  }
}
