import 'package:get/get.dart';
import '../../data/models/category.dart';

class CategoriesController extends GetxController {
  final categories = <Category>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    
    categories.value = [
      Category(
        id: 'cat_1',
        name: 'Electronics',
        description: 'Mobile phones and tablets',
        productCount: 45,
        createdAt: DateTime.now(),
      ),
      Category(
        id: 'cat_2',
        name: 'Accessories',
        description: 'Phone accessories and gadgets',
        productCount: 78,
        createdAt: DateTime.now(),
      ),
      Category(
        id: 'cat_3',
        name: 'Parts',
        description: 'Replacement parts',
        productCount: 23,
        createdAt: DateTime.now(),
      ),
      Category(
        id: 'cat_4',
        name: 'Cases',
        description: 'Phone cases and covers',
        productCount: 10,
        createdAt: DateTime.now(),
      ),
    ];
    
    isLoading.value = false;
  }
}
