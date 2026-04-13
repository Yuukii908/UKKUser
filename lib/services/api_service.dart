import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiService {
  static const Duration _timeout = Duration(seconds: 10);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (!connectivityResult.contains(ConnectivityResult.mobile) &&
          !connectivityResult.contains(ConnectivityResult.wifi)) {
        return {
          'success': false,
          'message': 'Tidak ada koneksi internet',
        };
      }

      debugPrint('Calling URL: ${AppConfig.baseUrl}/api/v1/login');
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/v1/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Login API error: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message': 'Login gagal: ${response.body}',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server. Pastikan server berjalan.',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Koneksi gagal. Periksa URL server.',
      };
    } catch (e) {
      debugPrint('Login error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (!connectivityResult.contains(ConnectivityResult.mobile) &&
          !connectivityResult.contains(ConnectivityResult.wifi)) {
        return {
          'success': false,
          'message': 'Tidak ada koneksi internet',
        };
      }

      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/api/v1/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      ).timeout(_timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Register API error: ${response.statusCode} - ${response.body}');
        return {
          'success': false,
          'message': 'Registrasi gagal: ${response.body}',
        };
      }
    } on SocketException {
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server. Pastikan server berjalan.',
      };
    } on http.ClientException {
      return {
        'success': false,
        'message': 'Koneksi gagal. Periksa URL server.',
      };
    } catch (e) {
      debugPrint('Register error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
