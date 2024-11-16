import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

const String apiUrl = 'https://localhost:7065/api';

class ApiService {
  final Logger _logger = Logger();

  // Método para el inicio de sesión
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/Users/login');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        _logger.i('Inicio de sesión exitoso');
        return true;
      } else {
        _logger.e('Error en el inicio de sesión: ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.e('Error: $e');
      return false;
    }
  }

  // Método para registrar un nuevo usuario
  Future<bool> register(String username, String email, String password) async {
    final url = Uri.parse('$apiUrl/Users/register');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        _logger.i('Registro exitoso');
        return true;
      } else {
        _logger.e('Error en el registro: ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.e('Error: $e');
      return false;
    }
  }
}
