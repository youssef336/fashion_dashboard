import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/views/widgets/product_item.dart';
import 'package:flutter/material.dart';

class DeleteProductViewBody extends StatelessWidget {
  const DeleteProductViewBody({super.key, required this.products});
  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          mainAxisSpacing: 20,
          crossAxisSpacing: 15,
          mainAxisExtent: 300,
        ),
        itemCount: products.length, // Use actual products length
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
          ); // Changed to product singular
        },
      ),
    );
  }
}
