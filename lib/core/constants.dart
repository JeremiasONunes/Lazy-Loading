import 'package:flutter/material.dart';

class AppConstants {
  // API
  static const String apiUrl =
      'https://restcountries.com/v3.1/independent?status=true';
  static const int pageSize = 10;

  // Paleta de cores monocromática analógica
  static const Color primaryColor = Color(0xFF32FA75);
  static const Color secondaryColor = Color(0xFF32FAB2);
  static const Color accentColor = Color(0xFF32FA3D);

  // Estilo minimalista - padding e radius padrão
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
}
