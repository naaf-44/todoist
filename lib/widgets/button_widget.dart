import 'package:flutter/material.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/widgets/text_widget.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const PrimaryButton({
    super.key,
    this.text = "",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      child: PrimaryButtonText(text: text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  const SecondaryButton({super.key, this.text = "", this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.primaryColor, width: 1)),
        backgroundColor: AppColors.whiteColor,
      ),
      child: SecondaryButtonText(text: text),
    );
  }
}

class PrimaryIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;

  const PrimaryIconButton(
      {super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(iconData),
      color: AppColors.primaryColor,
    );
  }
}

class SecondaryIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;

  const SecondaryIconButton(
      {super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Icon(iconData),
      color: AppColors.whiteColor,
    );
  }
}
