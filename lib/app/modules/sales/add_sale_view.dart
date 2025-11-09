import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/sale.dart';
import '../../data/models/product.dart';
import '../../theme/app_theme.dart';
import 'sales_controller.dart';
import '../products/products_controller.dart';

class AddSaleView extends GetView<SalesController> {
  const AddSaleView({super.key});

  @override
  Widget build(BuildContext context) {
    final customerNameController = TextEditingController();
    final quantityController = TextEditingController();
    final selectedProduct = Rx<Product?>(null);

    // Get products controller to access product list
    final productsController = Get.find<ProductsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Sale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Obx(() {
                  final products = productsController.products;
                  final inStockProducts = products.where((p) => p.stock > 0).toList();
                  
                  return DropdownButtonFormField<Product>(
                    value: selectedProduct.value,
                    decoration: const InputDecoration(
                      labelText: 'Product',
                      hintText: 'Select a product',
                    ),
                    items: inStockProducts
                        .map((product) => DropdownMenuItem(
                              value: product,
                              child: Text('${product.name} (\$${product.price.toStringAsFixed(2)}) - Stock: ${product.stock}'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedProduct.value = value;
                    },
                  );
                }),
                const SizedBox(height: 16),
                TextField(
                  controller: customerNameController,
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    hintText: 'Enter customer name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    hintText: 'Enter quantity',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                Obx(() {
                  if (selectedProduct.value == null) {
                    return const SizedBox.shrink();
                  }
                  final product = selectedProduct.value!;
                  final quantity = int.tryParse(quantityController.text) ?? 0;
                  final total = product.price * quantity;
                  
                  return Card(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sale Summary',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Unit Price: \$${product.price.toStringAsFixed(2)}'),
                          Text('Quantity: $quantity'),
                          const Divider(),
                          Text(
                            'Total: \$${total.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (selectedProduct.value == null ||
                        customerNameController.text.isEmpty ||
                        quantityController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please fill in all required fields',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final product = selectedProduct.value!;
                    final quantity = int.tryParse(quantityController.text) ?? 0;

                    if (quantity <= 0) {
                      Get.snackbar(
                        'Error',
                        'Please enter a valid quantity',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    if (quantity > product.stock) {
                      Get.snackbar(
                        'Error',
                        'Insufficient stock. Available: ${product.stock}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final sale = Sale(
                      id: 'sale_${DateTime.now().millisecondsSinceEpoch}',
                      productId: product.id,
                      productName: product.name,
                      quantity: quantity,
                      unitPrice: product.price,
                      totalAmount: product.price * quantity,
                      saleDate: DateTime.now(),
                      customerName: customerNameController.text,
                    );

                    controller.addSale(sale);
                    productsController.updateProductStock(product.id, quantity);
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Record Sale'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
