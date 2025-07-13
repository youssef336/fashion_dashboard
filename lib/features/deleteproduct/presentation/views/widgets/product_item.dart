import 'package:fashion_dashboard/core/entities/product_entity.dart';
import 'package:fashion_dashboard/features/deleteproduct/presentation/manager/cubits/fetchproducts/fetchproducts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.network(product.image!, fit: BoxFit.fill),
              ),
              const SizedBox(height: 10),

              Text(
                product.name,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
              ),
              Text(
                product.description,
                style: const TextStyle(color: Colors.grey),

                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                product.price.toString(),
                style: const TextStyle(color: Color(0xffDD8560)),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<FetchproductsCubit>().deleteProduct(
                  product.docmentId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
