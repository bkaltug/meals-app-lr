import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({required this.currentFilters, super.key});
  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeState = false;
  var _lactoseFreeState = false;
  var _vegetarianState = false;
  var _veganState = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeState = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeState = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianState = widget.currentFilters[Filter.vegetarian]!;
    _veganState = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filters"),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.glutenFree: _glutenFreeState,
              Filter.lactoseFree: _lactoseFreeState,
              Filter.vegetarian: _vegetarianState,
              Filter.vegan: _veganState
            });
            return false;
          },
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                activeColor: Theme.of(context).colorScheme.tertiary,
                value: _glutenFreeState,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenFreeState = isChecked;
                  });
                },
                title: Text(
                  "Gluten-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  "Only include gluten-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                activeColor: Theme.of(context).colorScheme.tertiary,
                value: _lactoseFreeState,
                onChanged: (isChecked) {
                  setState(() {
                    _lactoseFreeState = isChecked;
                  });
                },
                title: Text(
                  "Lactose-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  "Only include lactose-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                activeColor: Theme.of(context).colorScheme.tertiary,
                value: _vegetarianState,
                onChanged: (isChecked) {
                  setState(() {
                    _vegetarianState = isChecked;
                  });
                },
                title: Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  "Only include vegetarian meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
                activeColor: Theme.of(context).colorScheme.tertiary,
                value: _veganState,
                onChanged: (isChecked) {
                  setState(() {
                    _veganState = isChecked;
                  });
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  "Only include vegan meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              )
            ],
          ),
        ));
  }
}
