import 'package:flutter/material.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/widgets/filter_toggle_tile.dart';

enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<FilterType, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[FilterType.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[FilterType.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[FilterType.vegetarian]!;
    _veganFilterSet = widget.currentFilters[FilterType.vegan]!;
    // No need to call setState because initState is called before the widget is rendered (before the build method is executed)
  }

  void _toggleFilter(bool isChecked, String filterName) {
    switch (filterName) {
      case 'gluten-free':
        setState(() {
          _glutenFreeFilterSet = isChecked;
        });
        break;
      case 'lactose-free':
        setState(() {
          _lactoseFreeFilterSet = isChecked;
        });
        break;
      case 'vegetarian':
        setState(() {
          _vegetarianFilterSet = isChecked;
        });
        break;
      case 'vegan':
        setState(() {
          _veganFilterSet = isChecked;
        });
        break;
    }
  }

  // void _setScreen(String identifier) {
  //   // Close the drawer
  //   Navigator.of(context).pop();

  //   switch (identifier) {
  //     case 'meals':
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (ctx) => const TabsScreen(),
  //         ),
  //       );
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: _setScreen,
      // ),
      body: WillPopScope(
        onWillPop: () async {
          //Pass the result back to the previous screen
          Navigator.of(context).pop({
            FilterType.glutenFree: _glutenFreeFilterSet,
            FilterType.lactoseFree: _lactoseFreeFilterSet,
            FilterType.vegetarian: _vegetarianFilterSet,
            FilterType.vegan: _veganFilterSet
          });
          return false;
        },
        child: Column(
          children: [
            FilterToggleTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                _toggleFilter(isChecked, 'gluten-free');
              },
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
            ),
            FilterToggleTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                _toggleFilter(isChecked, 'lactose-free');
              },
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
            ),
            FilterToggleTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                _toggleFilter(isChecked, 'vegetarian');
              },
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
            ),
            FilterToggleTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                _toggleFilter(isChecked, 'vegan');
              },
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
