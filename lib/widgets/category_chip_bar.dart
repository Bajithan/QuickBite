import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryChipBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  const CategoryChipBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'meals':
        return Icons.lunch_dining;
      case 'beverages':
        return Icons.local_cafe;
      case 'snacks':
        return Icons.cookie;
      default:
        return Icons.restaurant_menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return ChoiceChip(
            avatar: Icon(
              _getCategoryIcon(category),
              size: 16,
              color: isSelected ? Colors.white : AppTheme.textSecondary,
            ),
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onSelected(category),
            selectedColor: AppTheme.primary,
            backgroundColor: AppTheme.surface,
            side: BorderSide(
              color: isSelected ? AppTheme.primary : AppTheme.border,
            ),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textPrimary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
          );
        },
      ),
    );
  }
}
