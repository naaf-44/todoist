import 'package:flutter/material.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: const TitleText(text: "Todos"),
          backgroundColor: AppColors.primaryColor,
          actions: [
            SecondaryIconButton(iconData: Icons.add, onPressed: (){}),
          ],
        ),
        body: const Center(child: PrimaryButton(text: "Click"),),
    );
  }
}