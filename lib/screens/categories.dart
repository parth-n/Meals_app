import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/categorygriditem.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animateController;

  @override
  void initState() {
    super.initState();

    _animateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      //lowerBound: 0,
      //upperBound: 1) these values are by default 0 and 1, can be used to set different values
    );

    _animateController.forward();
  }

  @override
  void dispose() {
    _animateController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    //it will push the route which will be a widget on top of current stack of screens.
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
            ))); //Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animateController,
        child: GridView(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: [
              //availableCategories.map((category) => CategoryGridItem(category: category)).toList() is an alternative for for loop
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onselectCategory: () {
                    _selectCategory(context, category);
                  },
                )
            ]),
        builder: (context, child) => Padding(
              padding:
                  EdgeInsets.only(top: 100 - _animateController.value * 100),
              child: child,
            ));
  }
}
