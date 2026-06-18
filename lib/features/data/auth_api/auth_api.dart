import "dart:convert";

import "package:ecommerce_app_api_26/core/api/endpoints.dart";
import "package:ecommerce_app_api_26/core/storage/storage_helper.dart";
import "package:ecommerce_app_api_26/features/data/models/request/login_request.dart";
import "package:ecommerce_app_api_26/features/data/models/request/sign_up_request.dart";
import "package:ecommerce_app_api_26/features/data/models/response/error_model.dart";
import "package:ecommerce_app_api_26/features/data/models/response/error_signup.dart";
import "package:ecommerce_app_api_26/features/data/models/response/signup_model.dart";
import "package:ecommerce_app_api_26/features/data/models/response/token.dart";
import "package:http/http.dart" as http;

class AuthApi {
  Future<Token_model> login({String? email, String? password}) async {
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.login);
   LoginRequestModel loginRequest= LoginRequestModel(email: email,password: password);
    var response = await http.post(
      url,
      body: jsonEncode(loginRequest.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Token_model tokenModel = Token_model.fromJson(json);
      StorageHelper.saveToken(tokenModel.accessToken!);
      return tokenModel;
    } else {
      ErrorModel errorModel = ErrorModel.fromJson(json);
      throw Exception(errorModel.message);
    }
  }
  Future<SignupModel> signup(String name, String email, String password)async {
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.signUp);
    SignUpRequestModel signUpRequestModel =SignUpRequestModel(name: name,email: email,password: password,avatar: "https://picsum.photos/800");
    var response = await http.post(
      url,
      body: jsonEncode(signUpRequestModel),
      headers: {"Content-Type": "application/json"},
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      SignupModel signupModel = SignupModel.fromJson(json);
      return signupModel;
    } else {
      ErrorSignupModel errorSignupModel = ErrorSignupModel.fromJson(json);
      throw Exception(errorSignupModel.message);
    }
  }
}