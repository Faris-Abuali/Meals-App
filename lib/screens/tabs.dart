import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
// import 'package:meals/data/dummy_data.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  // The ConsumerState<T> class has a property called 'ref' that is of type ProviderReference.
  // and it is globally available to all the methods in this class.
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // static const Map<int, Map> map = {
  //   0: {
  //     'title': 'Categories',
  //     'screen': CategoriesScreen(),
  //   },
  //   1: {
  //     'title': 'Favorites',
  //     'screen': MealsScreen(title: 'Favorites', meals: []),
  //   },
  // };

  void _setScreen(String identifier) async {
    // Close the drawer
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      Navigator.of(context).push<Map<FilterType, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }

    if (identifier == 'meals') {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      /** 
       * The riverpod package automatically extracts the 'state' property
       * value from the notifier class that belongs to the provider.
       * Hence, ref.watch() yields List<Meal> here (instead of the Notifier class).
       */
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    // final currentScreenMap = map[_selectedPageIndex];
    // activePageTitle = currentScreenMap!['title'];
    // activePage = currentScreenMap['screen'];

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
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
    );
  }
}
