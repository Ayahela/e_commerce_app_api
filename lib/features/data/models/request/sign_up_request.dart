class SignUpRequestModel {
String ? name;
String ? email;
String ? password;
String ? avatar;

SignUpRequestModel({this.name,this.email, this.password,this.avatar});
Map<String,dynamic> toJson(){
  final Map<String,dynamic>data={};
  data['email'] =email;
  data['password']=password;
  data['name']=name;
  data['avatar']="https://picsum.photos/800";

  return data;
}

}
