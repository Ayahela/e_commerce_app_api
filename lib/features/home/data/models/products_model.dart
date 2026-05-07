import 'package:ecommerce_app_api_26/features/categories/data/models/Categories_model.dart';

class ProductsModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;


  ProductsModel(
      {this.id,
        this.title,
        this.slug,
        this.price,
        this.description,
        this.category,
        this.images,
        });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new CategoriesModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();

  }


}

