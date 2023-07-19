import 'package:flutter/material.dart';
import 'package:meals_app_5/screens/meals_screen.dart';
import 'package:meals_app_5/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorite_meals_provider.dart';
import 'categories_screen.dart';
import 'filters_screen.dart';
import '../providers/filter_provider.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedPageIndex = 0;

  Widget activePageTitle = const Text("Categories");

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (context) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = CategoriesScreen(
      availabaleMeals: availableMeals,
    );
    void selectPage(int index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        mealList: favoriteMeals,
      );
      activePageTitle = const Text("Favorites");
    } else {
      activeScreen = CategoriesScreen(
        availabaleMeals: availableMeals,
      );
      activePageTitle = const Text("Categories");
    }

    return Scaffold(
      appBar: AppBar(title: activePageTitle),
      drawer: MainDrawer(setScreen: setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
      body: activeScreen,
    );
  }
}
