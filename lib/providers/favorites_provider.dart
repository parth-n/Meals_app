import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteMealsNotfier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotfier() : super([]);
}

final favoriteMealsProvider = StateNotifierProvider();
