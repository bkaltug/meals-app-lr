import 'package:flutter/material.dart';
import 'package:meals_app_5/data/dummy_data.dart';
import 'package:meals_app_5/screens/meals_screen.dart';
import 'package:meals_app_5/widgets/main_drawer.dart';

import '../models/meal.dart';
import 'categories_screen.dart';
import 'filters_screen.dart';

Map<Filter, bool> kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  Widget activePageTitle = const Text("Categories");

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Removed ${meal.title} from favorites");
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage("Added ${meal.title} to favorites");
      }
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      Map<Filter, bool>? result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (context) => FilterScreen(
                    currentFilters: _selectedFilters,
                  )));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availabaleMeals: availableMeals,
    );
    void selectPage(int index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    if (selectedPageIndex == 1) {
      activeScreen = MealsScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
        mealList: _favoriteMeals,
      );
      activePageTitle = const Text("Favorites");
    } else {
      activeScreen = CategoriesScreen(
        onToggleFavorite: _toggleMealFavoriteStatus,
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
