import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/endpoints.dart';
import 'package:ecommerce_app_api_26/features/categories/data/models/Categories_model.dart';
import 'package:http/http.dart'as http;
class CategoriesApi {
  Future<List<CategoriesModel>> getAllCategories()async{
    Uri url =Uri.parse(EndPoint.baseurl+EndPoint.allcategories);
    var response=await  http.get(url);
    var json= jsonDecode(response.body) as List;
    List<CategoriesModel> categories= json.map((element){
      return CategoriesModel.fromJson(element);
    }).toList();
    return categories;
  }
  }