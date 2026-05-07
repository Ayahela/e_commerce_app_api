import 'package:ecommerce_app_api_26/features/categories/data/categories_api/categories_api.dart';
import 'package:ecommerce_app_api_26/features/categories/data/models/Categories_model.dart';
import 'package:ecommerce_app_api_26/features/categories/presentation/screens/category_product.dart';
import 'package:ecommerce_app_api_26/features/categories/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Electronics',
        'icon': Icons.electrical_services_outlined,
        'color': Colors.orange,
      },
      {
        'name': 'Fashion',
        'icon': Icons.checkroom_outlined,
        'color': Colors.pink,
      },
      {'name': 'Home', 'icon': Icons.home_work_outlined, 'color': Colors.green},
      {
        'name': 'Books',
        'icon': Icons.menu_book_outlined,
        'color': Colors.purple,
      },
      {'name': 'Beauty', 'icon': Icons.face_outlined, 'color': Colors.red},
      {
        'name': 'Sports',
        'icon': Icons.sports_basketball_outlined,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CategoriesApi().getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            );
          }
          List<CategoriesModel>? category = snapshot.data;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: category!.length,
            itemBuilder: (context, index) {
              final categories = category[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategoryProduct(id: categories.id ?? 1),
                    ),
                  );
                },
                child: CategoryCard(
                  id: categories.id,
                  name: categories.name,
                  imageUrl: categories.image,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
