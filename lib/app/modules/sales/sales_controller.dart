import 'package:get/get.dart';
import '../../data/models/sale.dart';

class SalesController extends GetxController {
  final sales = <Sale>[].obs;
  final isLoading = false.obs;
  final totalRevenue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSales();
  }

  Future<void> loadSales() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      
      sales.value = List.generate(15, (index) {
        final quantity = (index + 1) * 2;
        final unitPrice = 100.0 + (index * 50);
        return Sale(
          id: 'sale_$index',
          productId: 'prod_$index',
          productName: 'Mobile Phone ${index + 1}',
          quantity: quantity,
          unitPrice: unitPrice,
          totalAmount: unitPrice * quantity,
          saleDate: DateTime.now().subtract(Duration(days: index)),
          customerName: 'Customer ${index + 1}',
        );
      });
      
      totalRevenue.value = sales.fold(0.0, (sum, sale) => sum + sale.totalAmount);
    } catch (e) {
      // Handle error silently or log to error tracking service
      // ignore: avoid_print
      print('Error loading sales: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addSale(Sale sale) {
    sales.insert(0, sale); // Add to the beginning for chronological order
    totalRevenue.value += sale.totalAmount;
    Get.snackbar(
      'Success',
      'Sale recorded successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
