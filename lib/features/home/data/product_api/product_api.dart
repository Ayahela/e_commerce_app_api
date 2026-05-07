import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/endpoints.dart';
import 'package:ecommerce_app_api_26/features/home/data/models/products_model.dart';
import 'package:http/http.dart'as http;
class ProductApi {
 Future<List<ProductsModel>> getAllProducts()async{
    Uri url =Uri.parse(EndPoint.baseurl+EndPoint.allproducts);
  var response=await  http.get(url);
  var json= jsonDecode(response.body) as List;
  List<ProductsModel> products= json.map((element){
return ProductsModel.fromJson(element);
  }).toList();
   return products;
  }
   Future<List<ProductsModel>> getProductsById(int categoryId)async{
    Uri url =Uri.parse(EndPoint.baseurl+EndPoint.allproducts+"?categoryId=$categoryId");
  var response=await  http.get(url);
  var json= jsonDecode(response.body) as List;
  List<ProductsModel> products= json.map((element){
return ProductsModel.fromJson(element);
  }).toList();
   return products;
  }

}
