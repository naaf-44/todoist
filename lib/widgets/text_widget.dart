import 'package:flutter/material.dart';
import 'package:todoist/utils/app_colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleMedium);
  }
}

class BodyText extends StatelessWidget {
  final String text;
  const BodyText({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}

class LabelText extends StatelessWidget {
  final String text;
  const LabelText({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelLarge);
  }
}

class PrimaryButtonText extends StatelessWidget {
  final String text;
  const PrimaryButtonText({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.whiteColor));
  }
}

class SecondaryButtonText extends StatelessWidget {
  final String text;
  const SecondaryButtonText({super.key, this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.primaryColor));
  }
}
