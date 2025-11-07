import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../app/routes/app_routes.dart';
import '../app/utils/responsive.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = !Responsive.isMobile(context);
    
    return Container(
      width: isDesktop ? 280 : null,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Drawer(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.store,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Mobile Shop',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Management System',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: FontAwesomeIcons.chartLine,
              title: 'Dashboard',
              route: AppRoutes.DASHBOARD,
            ),
            _buildDrawerItem(
              context,
              icon: FontAwesomeIcons.mobile,
              title: 'Products',
              route: AppRoutes.PRODUCTS,
            ),
            _buildDrawerItem(
              context,
              icon: FontAwesomeIcons.layerGroup,
              title: 'Categories',
              route: AppRoutes.CATEGORIES,
            ),
            _buildDrawerItem(
              context,
              icon: FontAwesomeIcons.cartShopping,
              title: 'Sales',
              route: AppRoutes.SALES,
            ),
            _buildDrawerItem(
              context,
              icon: FontAwesomeIcons.boxes,
              title: 'Inventory',
              route: AppRoutes.INVENTORY,
            ),
            const Divider(height: 32),
            ListTile(
              leading: Icon(
                Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              title: const Text('Theme'),
              trailing: Switch(
                value: Get.isDarkMode,
                onChanged: (value) {
                  Get.changeThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isSelected = Get.currentRoute == route;
    
    return ListTile(
      selected: isSelected,
      leading: FaIcon(icon, size: 20),
      title: Text(title),
      onTap: () {
        if (!Responsive.isMobile(context)) {
          // Desktop: Just navigate
          Get.toNamed(route);
        } else {
          // Mobile: Navigate and close drawer
          Get.back();
          Get.toNamed(route);
        }
      },
    );
  }
}
