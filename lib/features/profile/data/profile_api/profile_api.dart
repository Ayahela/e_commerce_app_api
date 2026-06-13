import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/endpoints.dart';
import 'package:ecommerce_app_api_26/core/storage/storage_helper.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_error_model.dart';
import 'package:ecommerce_app_api_26/features/profile/data/models/profile_model.dart';

import "package:http/http.dart" as http;

class ProfileApi {
  Future<ProfileModel> getProfile()async{
    String? token = await StorageHelper.getToken();
    Uri url =Uri.parse(EndPoint.baseurl+EndPoint.profile);
    var response = await http.get(url,
    headers:{"Authorization": "Bearer $token"}
    );
    var json = jsonDecode(response.body);
if(response.statusCode==201|| response.statusCode==200){
  ProfileModel profileModel=ProfileModel.fromJson(json);
  return profileModel;
}
else{
  ProfileErrorModel errorModel= ProfileErrorModel.fromJson(json);
  throw Exception(errorModel.message);
}
  }


  Future<void> updateAvatar(int userId, String avatarUrl,) async {
    Uri url = Uri.parse(EndPoint.baseurl + "users/$userId",);
    var response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "avatar": avatarUrl,
      }),
    );
    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to update avatar");
    }


  }
}


