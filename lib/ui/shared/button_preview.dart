import 'package:flutter/material.dart';
import 'package:pion_app/core/assets/assets.gen.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';

class ButtonPreview extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const ButtonPreview({
    super.key,
    required this.onTap,
    this.label = 'Lihat PDF',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.svg.iconVisibility.svg(
              width: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppFonts.medium.copyWith(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
