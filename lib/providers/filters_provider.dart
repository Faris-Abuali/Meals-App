import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum FilterType {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

const kInitialFilters = {
  FilterType.glutenFree: false,
  FilterType.lactoseFree: false,
  FilterType.vegetarian: false,
  FilterType.vegan: false,
};

class FiltersNotifier extends StateNotifier<Map<FilterType, bool>> {
  // we pass the initial state to the super
  FiltersNotifier() : super(kInitialFilters);

  void setFilter(FilterType filter, bool isActive) {
    // don't mutate state directly
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<FilterType, bool> chosenFilters) {
    // don't mutate state directly
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterType, bool>>(
  (ref) => FiltersNotifier(),
);

/// This is a dependent provider, meaning its function will be re-executed whenever
/// one of the watched providers state changes.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[FilterType.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterType.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterType.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[FilterType.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
