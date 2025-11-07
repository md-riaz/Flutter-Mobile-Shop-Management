import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../utils/responsive.dart';
import '../../theme/app_theme.dart';
import '../../../widgets/app_drawer.dart';
import 'sales_controller.dart';

class SalesView extends GetView<SalesController> {
  const SalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.snackbar('Info', 'Add sale feature coming soon');
            },
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

              return Column(
                children: [
                  _buildRevenueCard(context),
                  Expanded(child: _buildSalesList(context)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  FontAwesomeIcons.dollarSign,
                  color: AppTheme.successColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Revenue',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    '\$${NumberFormat('#,##0.00').format(controller.totalRevenue.value)}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppTheme.successColor,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesList(BuildContext context) {
    return Obx(() {
      if (controller.sales.isEmpty) {
        return const Center(child: Text('No sales found'));
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: controller.sales.length,
        itemBuilder: (context, index) {
          final sale = controller.sales[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                child: FaIcon(
                  FontAwesomeIcons.receipt,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
              ),
              title: Text(
                sale.productName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Customer: ${sale.customerName}'),
                  Text('Quantity: ${sale.quantity}'),
                  Text(DateFormat('MMM dd, yyyy').format(sale.saleDate)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${NumberFormat('#,##0.00').format(sale.totalAmount)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.successColor,
                    ),
                  ),
                  Text(
                    '\$${NumberFormat('#,##0.00').format(sale.unitPrice)} each',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
