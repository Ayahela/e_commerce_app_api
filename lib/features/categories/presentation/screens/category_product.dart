import 'package:flutter/material.dart';

import '../../../home/data/models/products_model.dart';
import '../../../home/data/product_api/product_api.dart';
import '../../../home/presentation/widgets/product_card.dart';
class CategoryProduct extends StatelessWidget {
  const CategoryProduct({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:   // Products Grid
      FutureBuilder(future: ProductApi().getProductsById(id), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasError||snapshot.data==null){
          return Center(child: Text("Error",style: TextStyle(fontSize: 25,color: Colors.red),));
        }
        List<ProductsModel>? products = snapshot.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products!.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                title: product.title??"No item",
                price: product.price?.toDouble()??0.0,
                description: product.description??"",
                image: product.images![0],
                productId: product.id!,
              );
            },
          ),
        );
      }),

    );
  }
}
