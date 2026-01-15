import 'dart:convert';
import 'package:e_commerce_app/products/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<ProductList>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) {
        return ProductList.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
