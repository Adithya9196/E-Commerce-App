import 'package:e_commerce_app/products/repo/product_repository.dart';
import 'package:get/get.dart';
import 'package:e_commerce_app/products/model/product_model.dart';

class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController({required this.repository});

  // Observables
  var products = <ProductList>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      var result = await repository.fetchProducts();
      products.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
