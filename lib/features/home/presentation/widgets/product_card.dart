import 'package:flutter/material.dart';

import '../../../../core/storage/non_sensitive_data.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final double price;
  final String description;
  final String image;
  final int productId;
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.productId,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. لازم يكون محاط بـ Expanded عشان ياخد مساحة من الكارد
          Expanded(
            child: Container(
              width: double.infinity,
              // 2. بنحط الصورة هنا في الـ decoration
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                // بنعمل تدرج لوني خفيف كـ background لحد ما الصورة تحمل
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                // 3. هنا الصورة الحقيقية بتظهر
                image: DecorationImage(
                  image: NetworkImage(widget.image), // الرابط النظيف
                  fit: BoxFit.cover, // السحر اللي بيظبط أبعاد الصورة
                  //onError: (exception, stackTrace) => print("Image Error: $exception"), // اختياري للـ debugging
                ),
              ),
              // 4. الـ Stack دلوقتي جواه بس الأيكونز (زي القلب)
              child: Stack(
                children: [
                  PositionBag(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.price}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),

                        onPressed: () async {
                          await NonSensitiveData.addToCart(widget.productId);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added To Cart")),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PositionBag extends StatelessWidget {
  final double? top;
  final double? right;
  final Widget child;
  const PositionBag({super.key, this.top, this.right, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(top: top, right: right, child: child);
  }
}
