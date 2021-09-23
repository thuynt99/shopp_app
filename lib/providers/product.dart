import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void setFavValue(newVal) {
    isFavorite = newVal;
    print(isFavorite);
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    var oldValue = isFavorite;
    setFavValue(!isFavorite);
    try {
      final url = Uri.parse(
          'https://shop-app-54400-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$authToken');
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        print(json.encode(response.body));
        setFavValue(oldValue);
      }
    } catch (e) {
      print(e);
      setFavValue(oldValue);
    }
  }
}
