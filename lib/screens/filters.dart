import 'package:flutter/material.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/widgets/filter_toggle_tile.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  void toggleFilter(WidgetRef ref, FilterType filter, bool isChecked) {
    ref.read(filtersProvider.notifier).setFilter(
          filter,
          isChecked,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use watch() here, because we want to re-execute this build method
    // when the filtersProvider state changes.
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterToggleTile(
            value: activeFilters[FilterType.glutenFree]!,
            onChanged: (isChecked) {
              toggleFilter(ref, FilterType.glutenFree, isChecked);
            },
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FilterToggleTile(
            value: activeFilters[FilterType.lactoseFree]!,
            onChanged: (isChecked) {
              toggleFilter(ref, FilterType.lactoseFree, isChecked);
            },
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FilterToggleTile(
            value: activeFilters[FilterType.vegetarian]!,
            onChanged: (isChecked) {
              toggleFilter(ref, FilterType.vegetarian, isChecked);
            },
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
          ),
          FilterToggleTile(
            value: activeFilters[FilterType.vegan]!,
            onChanged: (isChecked) {
              toggleFilter(ref, FilterType.vegan, isChecked);
            },
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
          ),
        ],
      ),
    );
  }
}
