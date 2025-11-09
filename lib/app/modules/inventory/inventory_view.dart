import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../utils/responsive.dart';
import '../../theme/app_theme.dart';
import '../../../widgets/app_drawer.dart';
import 'inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.loadInventory,
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Responsive.isMobile(context) ? const AppDrawer() : null,
      body: Row(
        children: [
          if (!Responsive.isMobile(context)) const AppDrawer(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.lowStockProducts.isNotEmpty)
                      _buildLowStockAlert(context),
                    const SizedBox(height: 24),
                    Text(
                      'All Products',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    _buildInventoryTable(context),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockAlert(BuildContext context) {
    return Card(
      color: AppTheme.warningColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: AppTheme.warningColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Low Stock Alert',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${controller.lowStockProducts.length} products have low stock (< 20 units)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryTable(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Stock')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.inventory.map((product) {
              final isLowStock = product.stock < 20;
              return DataRow(
                cells: [
                  DataCell(Text(product.name)),
                  DataCell(Text(product.category)),
                  DataCell(Text('\$${NumberFormat('#,##0.00').format(product.price)}')),
                  DataCell(Text('${product.stock}')),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isLowStock
                            ? AppTheme.warningColor.withOpacity(0.1)
                            : AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isLowStock ? 'Low Stock' : 'In Stock',
                        style: TextStyle(
                          color: isLowStock
                              ? AppTheme.warningColor
                              : AppTheme.successColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.add),
                      tooltip: 'Restock',
                      onPressed: () => _showRestockDialog(context, product.id),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showRestockDialog(BuildContext context, String productId) {
    final quantityController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Restock Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the quantity to add to stock:'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter quantity',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text);
              if (quantity == null || quantity <= 0) {
                Get.snackbar(
                  'Error',
                  'Please enter a valid quantity',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppTheme.errorColor,
                  colorText: Colors.white,
                );
                return;
              }
              controller.restockProduct(productId, quantity);
              Get.back();
            },
            child: const Text('Restock'),
          ),
        ],
      ),
    );
  }
}
