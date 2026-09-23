import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int minQuantity;
  final int maxQuantity;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.minQuantity = 1,
    this.maxQuantity = 99,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            color: quantity > minQuantity ? AppTheme.textPrimary : AppTheme.textSecondary.withOpacity(0.5),
            onPressed: quantity > minQuantity ? () => onChanged(quantity - 1) : null,
            splashRadius: 20,
            constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            color: quantity < maxQuantity ? AppTheme.primary : AppTheme.textSecondary.withOpacity(0.5),
            onPressed: quantity < maxQuantity ? () => onChanged(quantity + 1) : null,
            splashRadius: 20,
            constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
          ),
        ],
      ),
    );
  }
}
