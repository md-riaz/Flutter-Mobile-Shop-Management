import 'package:get/get.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/products/products_binding.dart';
import '../modules/products/products_view.dart';
import '../modules/products/product_detail_view.dart';
import '../modules/products/add_product_view.dart';
import '../modules/categories/categories_binding.dart';
import '../modules/categories/categories_view.dart';
import '../modules/sales/sales_binding.dart';
import '../modules/sales/sales_view.dart';
import '../modules/inventory/inventory_binding.dart';
import '../modules/inventory/inventory_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCTS,
      page: () => const ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: AppRoutes.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: AppRoutes.SALES,
      page: () => const SalesView(),
      binding: SalesBinding(),
    ),
    GetPage(
      name: AppRoutes.INVENTORY,
      page: () => const InventoryView(),
      binding: InventoryBinding(),
    ),
  ];
}
