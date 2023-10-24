import 'package:flutter/material.dart';
import 'package:flutter_dicoding/src/model/product.dart';
import 'package:flutter_dicoding/src/pages/detail_page.dart';
import 'package:flutter_dicoding/src/widget/container_item.dart';

class ContainerCard extends StatelessWidget {
  final List<Product>? products;
  final int gridCount;
  final int carts;
  const ContainerCard(
      {required this.products, required this.gridCount, required this.carts, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: gridCount,
        ),
        itemCount: products!.length,
        itemBuilder: (context, index) {
          return ContainerItem(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      products: products![index], carts: carts
                    ),
                  ));
            },
            title: products![index].title,
            price: products![index].price,
            image: products![index].thumbnail,
          );
        },
      ),
    );
  }
}
