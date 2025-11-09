import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';
import 'products_controller.dart';
import 'edit_product_view.dart';

class ProductDetailView extends GetView<ProductsController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get product ID from route parameters
    final productId = Get.parameters['id'] ?? '';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final product = controller.products.firstWhereOrNull(
                (p) => p.id == productId,
              );
              if (product != null) {
                Get.to(() => EditProductView(product: product));
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context, productId),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final product = controller.products.firstWhereOrNull(
          (p) => p.id == productId,
        );

        if (product == null) {
          return const Center(
            child: Text('Product not found'),
          );
        }

        final isLowStock = product.stock < 20;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image
              Container(
                height: Responsive.isMobile(context) ? 250 : 400,
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.mobile,
                    size: Responsive.isMobile(context) ? 80 : 120,
                    color: AppTheme.primaryColor.withOpacity(0.5),
                  ),
                ),
              ),
              
              // Product Details
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Category
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Price
                    Row(
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '\$${NumberFormat('#,##0.00').format(product.price)}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Stock Status
                    Card(
                      color: isLowStock
                          ? AppTheme.warningColor.withOpacity(0.1)
                          : AppTheme.successColor.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            FaIcon(
                              isLowStock
                                  ? FontAwesomeIcons.triangleExclamation
                                  : FontAwesomeIcons.check,
                              color: isLowStock
                                  ? AppTheme.warningColor
                                  : AppTheme.successColor,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isLowStock ? 'Low Stock' : 'In Stock',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isLowStock
                                          ? AppTheme.warningColor
                                          : AppTheme.successColor,
                                    ),
                                  ),
                                  Text(
                                    '${product.stock} units available',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Description
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    
                    // Additional Information
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Additional Information',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow(
                              context,
                              'Product ID',
                              product.id,
                            ),
                            const Divider(),
                            _buildInfoRow(
                              context,
                              'Created',
                              DateFormat('MMM dd, yyyy').format(product.createdAt),
                            ),
                            if (product.updatedAt != null) ...[
                              const Divider(),
                              _buildInfoRow(
                                context,
                                'Last Updated',
                                DateFormat('MMM dd, yyyy').format(product.updatedAt!),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String productId) {
    final product = controller.products.firstWhereOrNull(
      (p) => p.id == productId,
    );
    
    if (product == null) return;

    Get.dialog(
      AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteProduct(product.id);
              Get.back(); // Close dialog
              Get.back(); // Go back to products list
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorColor,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
