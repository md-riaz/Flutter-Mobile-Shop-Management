import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/category.dart';
import '../../theme/app_theme.dart';
import 'categories_controller.dart';

class AddCategoryView extends GetView<CategoriesController> {
  const AddCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'Enter category name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter category description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please fill in all required fields',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppTheme.errorColor,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    final category = Category(
                      id: 'cat_${DateTime.now().millisecondsSinceEpoch}',
                      name: nameController.text,
                      description: descriptionController.text,
                      productCount: 0,
                      createdAt: DateTime.now(),
                    );

                    controller.addCategory(category);
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Add Category'),
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
