import 'package:get/get.dart';
import '../../data/models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock products data
      products.value = List.generate(20, (index) {
        final categories = ['Electronics', 'Accessories', 'Parts', 'Cases'];
        return Product(
          id: 'prod_$index',
          name: 'Mobile Phone ${index + 1}',
          description: 'High-quality smartphone with amazing features and specifications',
          price: 299.99 + (index * 50),
          stock: 100 - (index * 3),
          category: categories[index % categories.length],
          createdAt: DateTime.now().subtract(Duration(days: index)),
        );
      });
    } catch (e) {
      // Handle error silently or log to error tracking service
      // ignore: avoid_print
      print('Error loading products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Product> get filteredProducts {
    var filtered = products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );
      final matchesCategory = selectedCategory.value == 'All' ||
          product.category == selectedCategory.value;
      return matchesSearch && matchesCategory;
    }).toList();
    
    return filtered;
  }

  void searchProducts(String query) {
    searchQuery.value = query;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  void deleteProduct(String id) {
    products.removeWhere((product) => product.id == id);
    Get.snackbar(
      'Success',
      'Product deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addProduct(Product product) {
    products.add(product);
    Get.snackbar(
      'Success',
      'Product added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
