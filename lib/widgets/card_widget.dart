import 'package:flutter/material.dart';
import 'package:todoist/utils/app_colors.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: AppColors.primaryColor,
        ),
      ),
      elevation: 2,
      shadowColor: AppColors.primaryColor,
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }
}
