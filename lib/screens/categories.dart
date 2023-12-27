import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // Use `later` to tell dart that this variable will be initialized later.
  late AnimationController _animationController; // for Explicit Animation

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // to fire the animation once per frame (e.g. 60fps)
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, // in animation you animate between 2 values
      upperBound: 1, // 0 & 1 are the default values.
    );

    _animationController.forward(); // start the animation
  }

  @override
  void dispose() {
    _animationController
        .dispose(); // to remove from memory when the widget is removed from the tree.
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 3 / 2, // 1.5:1 ratio
          crossAxisSpacing: 20, // 20px spacing between columns
          mainAxisSpacing: 20, // 20px spacing between rows
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      // The child will not be rebuilt when the animation is running.
      builder: (context, child) => SlideTransition(
        // padding: EdgeInsets.only(
        //   top: 100 - (_animationController.value * 100), // 100 - (0 -> 100)
        // ),

        // position: _animationController.drive(
        //   Tween<Offset>(
        //     begin: const Offset(0, 0.3),
        //     end: const Offset(0, 0),
        //   ),
        // ),
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
