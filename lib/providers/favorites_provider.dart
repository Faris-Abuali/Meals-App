import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); // we pass the initial state to the super

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavoriteMeal = state.contains(meal);

    // don't mutate state directly
    isFavoriteMeal
        ? state = state.where((m) => m.id != meal.id).toList()
        : state = [...state, meal];

    return !isFavoriteMeal; // return the new status
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
