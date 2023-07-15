import 'package:flutter/material.dart';
import 'package:meals_app_5/models/meal.dart';
import 'package:meals_app_5/screens/meal_details_screen.dart';
import 'package:meals_app_5/widgets/meal_item/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {required this.onToggleFavorite,
      this.title,
      required this.mealList,
      super.key});
  final List<Meal> mealList;
  final String? title;
  final void Function(Meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((ctx) => MealDetailsScreen(
              onToggleFavorite: onToggleFavorite,
              meal: meal,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: mealList.length,
      itemBuilder: (ctx, index) {
        return MealItem(
          meal: mealList[index],
          onSelectMeal: (meal) => selectMeal(context, meal),
        );
      },
    );

    if (mealList.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh... Nothing to see here!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Try selecting a different category",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
