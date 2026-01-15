import 'package:e_commerce_app/products/ui/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final WishlistController controller = Get.find<WishlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff6D5DF6),
          title: const Text("My Wishlist",style: TextStyle(color: Colors.white),)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.wishlistItems.isEmpty) {
          return const Center(child: Text("Your wishlist is empty"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.wishlistItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = controller.wishlistItems[index];

            return InkWell(
              onTap: () {
                Get.to(() => ProductDetailPage(product: product));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            product.image,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),

                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              controller.toggleWishlist(product);
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        product.title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "₹${product.price}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
