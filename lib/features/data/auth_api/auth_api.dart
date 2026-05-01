import "dart:convert";

import "package:ecommerce_app_api_26/core/api/endpoints.dart";
import "package:ecommerce_app_api_26/features/data/models/error_model.dart";
import "package:ecommerce_app_api_26/features/data/models/token.dart";
import "package:http/http.dart" as http;

class AuthApi {
  Future<Token_model> login(String email, String password) async {
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.login);
    Map<String, dynamic> requestBody = {"email": email, "password": password};
    var response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {"Content-Type": "application/json"},
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Token_model tokenModel = Token_model.fromJson(json);
      return tokenModel;
    } else {
      ErrorModel errorModel = ErrorModel.fromJson(json);
      throw Exception(errorModel.message);
    }
  }
  Future<Token_model> signup(String name, String email, String password)async {
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.signUp);
    Map<String, dynamic> requestBody = {"name":name,"email": email, "password": password,"avatar": "https://picsum.photos/800"};
    var response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {"Content-Type": "application/json"},
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Token_model tokenModel = Token_model.fromJson(json);
      return tokenModel;
    } else {
      ErrorModel errorModel = ErrorModel.fromJson(json);
      throw Exception(errorModel.message);
    }
  }
}
