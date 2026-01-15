import 'package:e_commerce_app/cart/controller/cart_controller.dart';
import 'package:e_commerce_app/cart/ui/cart_page.dart';
import 'package:e_commerce_app/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductList product;
  final RxBool isWishlist = false.obs;
  final CartController cartController = Get.put(CartController());

  ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Obx(
                () => IconButton(
              icon: Icon(
                isWishlist.value ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () {
                isWishlist.value = !isWishlist.value;
                Get.snackbar(
                  "Wishlist",
                  isWishlist.value
                      ? "${product.title} added to wishlist"
                      : "${product.title} removed from wishlist",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: Colors.black,
                  margin: const EdgeInsets.all(12),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),

            // Title & Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title,
                      style:
                      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("₹${product.price}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Description
                  Text("Description",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800)),
                  const SizedBox(height: 8),
                  Text(product.description, style: const TextStyle(fontSize: 14, height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                final bool added = cartController.isInCart(product);

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      added ? Icons.shopping_bag_outlined : Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      added ? "View Cart" : "Add to Cart",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      added ? Colors.green : const Color(0xff6D5DF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (added) {
                        Get.to(() => CartPage());
                      } else {
                        cartController.addToCart(product);
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
