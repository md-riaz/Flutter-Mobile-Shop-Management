import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../utils/responsive.dart';
import '../../theme/app_theme.dart';
import '../../../widgets/app_drawer.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
          IconButton(
            icon: Icon(
              Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Responsive.isMobile(context) ? const AppDrawer() : null,
      body: Row(
        children: [
          if (!Responsive.isMobile(context))
            const AppDrawer(),
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
                    // Stats Cards
                    ResponsiveGridView(
                      childAspectRatio: Responsive.isMobile(context) ? 1.5 : 2,
                      children: [
                        _buildStatCard(
                          context,
                          'Total Products',
                          controller.totalProducts.value.toString(),
                          FontAwesomeIcons.boxOpen,
                          AppTheme.primaryColor,
                        ),
                        _buildStatCard(
                          context,
                          'Total Sales',
                          '\$${NumberFormat('#,##0.00').format(controller.totalSales.value)}',
                          FontAwesomeIcons.dollarSign,
                          AppTheme.successColor,
                        ),
                        _buildStatCard(
                          context,
                          'Low Stock',
                          controller.lowStockProducts.value.toString(),
                          FontAwesomeIcons.triangleExclamation,
                          AppTheme.warningColor,
                        ),
                        _buildStatCard(
                          context,
                          'Categories',
                          controller.totalCategories.value.toString(),
                          FontAwesomeIcons.layerGroup,
                          AppTheme.infoColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Charts and Recent Activity
                    Responsive(
                      mobile: Column(
                        children: [
                          _buildRecentSales(context),
                          const SizedBox(height: 24),
                          _buildTopProducts(context),
                        ],
                      ),
                      desktop: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildRecentSales(context)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildTopProducts(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FaIcon(icon, color: color, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSales(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Sales',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.recentSales.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final sale = controller.recentSales[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: FaIcon(
                      FontAwesomeIcons.receipt,
                      size: 18,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(sale.productName),
                  subtitle: Text(sale.customerName),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$${NumberFormat('#,##0.00').format(sale.totalAmount)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(sale.saleDate),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProducts(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Products',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.topProducts.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final product = controller.topProducts[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                    child: FaIcon(
                      FontAwesomeIcons.mobile,
                      size: 18,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.category),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$${NumberFormat('#,##0.00').format(product.price)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Stock: ${product.stock}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
