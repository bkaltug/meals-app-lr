import 'package:flutter/material.dart';
import 'package:meals_app_5/screens/meals_screen.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {required this.availabaleMeals,
      required this.onToggleFavorite,
      super.key});
  final List<Meal> availabaleMeals;

  final void Function(Meal) onToggleFavorite;

  void selectCategory(BuildContext context, Category category) {
    final filteredMeals = availabaleMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              title: category.title,
              mealList: filteredMeals,
              onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.only(left: 5, top: 30, right: 5, bottom: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectCategory: () => selectCategory(context, category)),
      ],
    );
  }
}
