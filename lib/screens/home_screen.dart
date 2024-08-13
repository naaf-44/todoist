import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoist/models/hive_model.dart';
import 'package:todoist/screens/todo_screen.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<HiveModel>? hiveModelBox;

  @override
  void initState() {
    super.initState();
    openHiveBox();
  }

  void openHiveBox() async {
    hiveModelBox = await Hive.openBox("hive_model");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const PrimaryButtonText(text: "Tasks"),
            backgroundColor: AppColors.primaryColor,
            bottom:  const TabBar(
              labelColor: AppColors.whiteColor,
              tabs: [
                Tab(icon: Icon(Icons.start), text: 'To Do'),
                Tab(icon: Icon(Icons.refresh), text: 'In Progress'),
                Tab(icon: Icon(Icons.check), text: 'Done'),
              ],
            ),
          ),
          body: hiveModelBox == null
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(children: [
                  TodoScreen(hiveModelBox: hiveModelBox!, status: "todo"),
                  TodoScreen(
                      hiveModelBox: hiveModelBox!, status: "in_progress"),
                  TodoScreen(hiveModelBox: hiveModelBox!, status: "done"),
                ])),
    );
  }
}
