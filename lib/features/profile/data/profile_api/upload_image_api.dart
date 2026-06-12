import 'dart:convert';
import 'package:ecommerce_app_api_26/features/profile/data/models/upload_error_model.dart';
import '../../../../core/api/endpoints.dart';
import '../models/upload_response_model.dart';
import 'dart:io';
import "package:http/http.dart" as http;
class UploadImageApi {
 Future<Upload_Response>uploadImage(File image)async{
    Uri url =Uri.parse(EndPoint.baseurl+EndPoint.upload);
   var request=http.MultipartRequest(
     'POST',
     url,
   );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        image.path,
      ),
    );
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var json =jsonDecode(responseBody);
    if(response.statusCode==201|| response.statusCode==200){
      Upload_Response profileModel=Upload_Response.fromJson(json);
      return profileModel;
    }
    else{
      UploadErrorModel errorModel= UploadErrorModel.fromJson(json);
      throw Exception(errorModel.message);
    }
  }
}