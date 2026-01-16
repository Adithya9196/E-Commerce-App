import 'package:e_commerce_app/cart/ui/cart_page.dart';
import 'package:e_commerce_app/products/repo/product_repository.dart';
import 'package:e_commerce_app/products/ui/product_detail_page.dart';
import 'package:e_commerce_app/profile/page/profile_page.dart';
import 'package:e_commerce_app/wishlist/controller/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_app/products/controller/product_controller.dart';
import 'package:e_commerce_app/products/model/product_model.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final ProductController controller = Get.put(
    ProductController(repository: ProductRepository()),
  );

  final WishlistController wishlistController = Get.put(WishlistController());
  final RxSet<int> cart = <int>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Products", style: TextStyle(fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfilePage());
            },
            icon: Icon(Icons.person),
          ),
          IconButton(onPressed: (){
            Get.to((CartPage()));
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar & Filter
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.search, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Product Grid
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: controller.products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final ProductList product = controller.products[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => ProductDetailPage(product: product));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        height: 150,
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Obx(() => GestureDetector(
                                        onTap: () {
                                          wishlistController.toggleWishlist(product);
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            wishlistController.isInWishlist(product)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "₹${product.price}",
                                    style:
                                    const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}