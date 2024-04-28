import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotfier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotfier() : super([]);

  bool toggleFavoriteMealsStatus(Meal meal) {
    //not allowed to edit the object in existing memory, cannot use add/remove methods on List. always create a new memory.

    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [
        ...state,
        meal
      ]; //used spread operator to individually add all elements of state list to new list and then add meal to new state list.
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotfier, List<Meal>>((ref) {
  return FavoriteMealsNotfier();
});
