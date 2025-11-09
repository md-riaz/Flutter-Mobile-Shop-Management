import 'package:get/get.dart';
import '../../data/models/product.dart';

class InventoryController extends GetxController {
  final inventory = <Product>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInventory();
  }

  Future<void> loadInventory() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      
      inventory.value = List.generate(12, (index) {
        return Product(
          id: 'prod_$index',
          name: 'Mobile Phone ${index + 1}',
          description: 'Product description',
          price: 299.99 + (index * 50),
          stock: 100 - (index * 8),
          category: 'Electronics',
          createdAt: DateTime.now(),
        );
      });
    } catch (e) {
      // Handle error silently or log to error tracking service
      // ignore: avoid_print
      print('Error loading inventory: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Product> get lowStockProducts {
    return inventory.where((product) => product.stock < 20).toList();
  }

  void restockProduct(String productId, int quantity) {
    final index = inventory.indexWhere((product) => product.id == productId);
    if (index != -1) {
      final product = inventory[index];
      final updatedProduct = product.copyWith(
        stock: product.stock + quantity,
        updatedAt: DateTime.now(),
      );
      inventory[index] = updatedProduct;
      Get.snackbar(
        'Success',
        'Product restocked successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
