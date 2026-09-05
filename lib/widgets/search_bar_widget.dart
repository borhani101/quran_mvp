import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// نوار جستجوی سفارشی (Custom Search Bar Widget)
/// Beautiful RTL search bar matching Quran app design
class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchPressed;
  final bool readOnly;

  const SearchBarWidget({
    super.key,
    this.controller,
    this.hintText = '...جستجو در قرآن',
    this.onChanged,
    this.onSearchPressed,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        textDirection: TextDirection.rtl,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textGrey,
            fontSize: 14,
          ),
          prefixIcon: GestureDetector(
            onTap: onSearchPressed,
            child: const Icon(
              Icons.search,
              color: AppColors.primaryDark,
              size: 22,
            ),
          ),
          suffixIcon: controller?.text.isNotEmpty == true
              ? GestureDetector(
                  onTap: () {
                    controller?.clear();
                    onChanged?.call('');
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          isDense: true,
        ),
        style: TextStyle(
          color: AppColors.textDark,
          fontSize: 14,
        ),
      ),
    );
  }
}
