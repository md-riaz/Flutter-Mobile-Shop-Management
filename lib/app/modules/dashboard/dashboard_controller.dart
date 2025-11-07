import 'package:get/get.dart';
import '../../data/models/product.dart';
import '../../data/models/sale.dart';

class DashboardController extends GetxController {
  final totalProducts = 0.obs;
  final totalSales = 0.0.obs;
  final lowStockProducts = 0.obs;
  final totalCategories = 0.obs;
  final isLoading = false.obs;
  final recentSales = <Sale>[].obs;
  final topProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() async {
    isLoading.value = true;
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    totalProducts.value = 156;
    totalSales.value = 45320.50;
    lowStockProducts.value = 12;
    totalCategories.value = 8;
    
    // Mock recent sales
    recentSales.value = List.generate(5, (index) {
      return Sale(
        id: 'sale_$index',
        productId: 'prod_$index',
        productName: 'Product ${index + 1}',
        quantity: (index + 1) * 2,
        unitPrice: 100.0 + (index * 50),
        totalAmount: (100.0 + (index * 50)) * ((index + 1) * 2),
        saleDate: DateTime.now().subtract(Duration(days: index)),
        customerName: 'Customer ${index + 1}',
      );
    });
    
    // Mock top products
    topProducts.value = List.generate(4, (index) {
      return Product(
        id: 'prod_$index',
        name: 'Top Product ${index + 1}',
        description: 'Best selling product',
        price: 299.99 + (index * 100),
        stock: 50 - (index * 10),
        category: 'Electronics',
        createdAt: DateTime.now(),
      );
    });
    
    isLoading.value = false;
  }

  void refreshData() {
    loadDashboardData();
  }
}
