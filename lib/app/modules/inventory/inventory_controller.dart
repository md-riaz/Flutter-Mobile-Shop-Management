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

  void loadInventory() async {
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
    
    isLoading.value = false;
  }

  List<Product> get lowStockProducts {
    return inventory.where((product) => product.stock < 20).toList();
  }
}
