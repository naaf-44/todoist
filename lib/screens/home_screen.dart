import 'package:flutter/material.dart';
import 'package:todoist/screens/todo_screen.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const PrimaryButtonText(text: "Tasks"),
            backgroundColor: AppColors.primaryColor,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.start), text: 'To Do'),
                Tab(icon: Icon(Icons.refresh), text: 'In Progress'),
                Tab(icon: Icon(Icons.close), text: 'Done'),
              ],
            ),
          ),
          body: TabBarView(children: [
            const TodoScreen(),
            Container(color: Colors.white),
            Container(color: Colors.white),
          ])),
    );
  }
}
