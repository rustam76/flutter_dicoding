import 'dart:async';
import 'dart:convert';
import 'package:flutter_dicoding/src/config/url.dart';
import 'package:flutter_dicoding/src/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>?> fetchDataProduct() async {
    final result = await http.get(Uri.parse(UrlData.url));

    if (result.statusCode == 200) {
      List<Product> products = productFromJson(result.body);
      return products;
    } else {
      throw Exception('error fetch data');
    }
  }

  Future<List<Product>> searchData(String search) async {
    final result = await http.get(Uri.parse(UrlData.url + "/search?q=$search"));
    if (result.statusCode == 200) {
      List<Product> products = productFromJson(result.body);
      return products;
    } else {
      throw Exception('error fetch data');
    }
  }

  Future<List<String>?> categoryProduct() async {
    final result = await http.get(Uri.parse(UrlData.url + "/categories"));
    if (result.statusCode == 200) {
      final List<dynamic> jsonCategories = json.decode(result.body);
      final List<String> categories = jsonCategories.cast<String>();
      return categories;
    } else {
      throw Exception('error fetch data');
    }
  }

  Future<List<Product>?> setCategoryData(String category) async {
    final result =
        await http.get(Uri.parse(UrlData.url + "/category/$category"));
    if (result.statusCode == 200) {
      List<Product> products = productFromJson(result.body);
      return products;
    } else {
      throw Exception('error fetch data');
    }
  }
}
