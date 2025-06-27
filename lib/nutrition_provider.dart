import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionProvider extends ChangeNotifier {
  double? sugar;
  double? calories;
  String? error;

  Future<void> fetchNutrition(String productName) async {
    sugar = null;
    calories = null;
    error = null;
    notifyListeners();

    try {
      final url = Uri.parse(
        'https://world.openfoodfacts.org/cgi/search.pl?search_terms=$productName&search_simple=1&json=1',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['products'] != null && data['products'].isNotEmpty) {
          final nutriments = data['products'][0]['nutriments'];
          sugar = (nutriments['sugars_100g'] ?? 0).toDouble();
          calories = (nutriments['energy-kcal_100g'] ?? 0).toDouble();
        } else {
          error = 'No data found for "$productName".';
        }
      } else {
        error = 'API error: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error: $e';
    }

    notifyListeners();
  }
}
