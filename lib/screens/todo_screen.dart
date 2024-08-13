import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:todoist/blocs/todos_bloc/todos_bloc.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/models/hive_model.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/screens/task_view_screen.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/utils/date_time_extension.dart';
import 'package:todoist/utils/get_it_setup.dart';
import 'package:todoist/widgets/add_content_dialog.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/card_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class TodoScreen extends StatelessWidget {
  final String status;
  final Box<HiveModel> hiveModelBox;

  const TodoScreen({super.key, this.status = "", required this.hiveModelBox});

  @override
  Widget build(BuildContext context) {
    BuildContext? blocContext;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocProvider(
          create: (context) =>
              TodosBloc(getIt<ApiServices>())..add(const GetAllTaskEvent()),
          child: BlocConsumer<TodosBloc, TodosState>(
            listener: (context, state) {},
            builder: (context, state) {
              blocContext = context;
              if (state.todoStatus == TodoStatus.initial ||
                  state.todoStatus == TodoStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.todoStatus == TodoStatus.loaded) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.getTaskModelList.length,
                    itemBuilder: (context, index) {
                      if (getStatusByById(state.getTaskModelList[index].id!) ==
                          status) {
                        return CardWidget(
                          child: ListTile(
                            title: TitleText(
                                text: state.getTaskModelList[index].content!),
                            leading: const Icon(Icons.task, size: 40, color: AppColors.primaryColor),
                            subtitle: BodyText(
                                text: DateTimeExtension.listTileDateFormat(
                                    state.getTaskModelList[index].createdAt!)),
                            onTap: () {
                              navigateToDetailsScreen(context,
                                  state.getTaskModelList[index], blocContext!);
                            },
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              } else {
                return Center(child: TitleText(text: state.error!));
              }
            },
          ),
        ),
        if (status == "todo")
          PrimaryButton(
              text: "Add Task",
              onPressed: () {
                addTask(blocContext!, context);
              })
      ],
    );
  }

  navigateToDetailsScreen(BuildContext context, GetTaskModel taskModelList,
      BuildContext blocContext) async {
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskViewScreen(
                  getTaskModel: taskModelList,
                  hiveModelBox: hiveModelBox,
                ))) ?? false;
    if (res) {
      blocContext.read<TodosBloc>().add(const GetAllTaskEvent(content: ""));
    }
  }

  addTask(BuildContext blocContext, BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    AddContentDialog().showAlert("Add Task", "Add", context, textFieldController, formKey, () {
      if (formKey.currentState!.validate()) {
        Navigator.of(context).pop();
        blocContext
            .read<TodosBloc>()
            .add(GetAllTaskEvent(content: textFieldController.text));
      }
    });
  }

  String getStatusByById(String id) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        return val.status!;
      }
    }
    return "";
  }
}
