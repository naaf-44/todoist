import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:todoist/blocs/comments_bloc/comments_bloc.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/models/hive_model.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/repos/api_service_impl.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/utils/date_time_extension.dart';
import 'package:todoist/utils/dio_service.dart';
import 'package:todoist/utils/get_it_setup.dart';
import 'package:todoist/widgets/add_content_dialog.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/card_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class TaskViewScreen extends StatelessWidget {
  final GetTaskModel? getTaskModel;
  final Box<HiveModel> hiveModelBox;

  const TaskViewScreen(
      {super.key, this.getTaskModel, required this.hiveModelBox});

  @override
  Widget build(BuildContext context) {
    BuildContext? blocContext;
    String selectedValue = "Select Status";
    bool isEdit = false;
    ValueNotifier valueNotifier = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const PrimaryButtonText(text: "Task Details"),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        actions: [
          ValueListenableBuilder(
              valueListenable: valueNotifier,
              builder: (context, value, _) {
                if(value){
                  return const CircularProgressIndicator(color: AppColors.whiteColor);
                } else {
                  return SecondaryIconButton(
                      onPressed: () {
                        updateTask(context, valueNotifier);
                      },
                      iconData: Icons.edit);
                }
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardWidget(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleText(text: "Content:"),
                            BodyText(
                              text: getTaskModel!.content!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  if (getStatusByById(getTaskModel!.id!) == "done")
                    CardWidget(
                        child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleText(text: "Started On"),
                            BodyText(text: getStartDate(getTaskModel!.id!)),
                            const Gap(10),
                            const TitleText(text: "Completed On"),
                            BodyText(
                                text: getCompletedDate(getTaskModel!.id!)),
                            const Gap(10),
                            const TitleText(text: "Total Time Spent"),
                            BodyText(
                                text: DateTimeExtension.getTotalTime(
                                    getTaskModel!.id!, hiveModelBox)),
                          ],
                        ),
                      ],
                    )),
                  const Gap(20),
                  if (getStatusByById(getTaskModel!.id!) != "done")
                    Row(
                      children: [
                        Expanded(
                            child: CardWidget(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleText(text: "Change Status"),
                              StatefulBuilder(builder: (context, setState) {
                                return DropdownButton<String>(
                                  value: selectedValue,
                                  isExpanded: true,
                                  hint: const TitleText(text: 'Change Status'),
                                  items: <String>[
                                    'Select Status',
                                    'Todo',
                                    'In Progress',
                                    'Done'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: LabelText(text: value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                    if (newValue != "Select Status") {
                                      String val =
                                          newValue!.replaceAll(" ", "_");
                                      changeStatus(getTaskModel!.id!,
                                          val.toLowerCase(), context);
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                        )),
                      ],
                    ),
                  const Gap(20),
                  TitleText(
                      text: "Comments: ${getTaskModel!.commentCount ?? 0}"),
                ],
              ),
            ),
            BlocProvider(
              create: (context) => CommentsBloc(getIt<ApiServices>())
                ..add(GetAllCommentsEvent(taskId: getTaskModel!.id!)),
              child: BlocConsumer<CommentsBloc, CommentsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  blocContext = context;
                  if (state.commentsStatus == CommentsStatus.initial ||
                      state.commentsStatus == CommentsStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.commentsStatus == CommentsStatus.loaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.allCommentsModelList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            elevation: 2,
                            shadowColor: AppColors.primaryColor,
                            child: ListTile(
                              title: TitleText(
                                  text: state
                                      .allCommentsModelList[index].content!),
                              leading: const Icon(Icons.task),
                              subtitle: BodyText(
                                  text: DateTimeExtension.listTileDateFormat(
                                      state.allCommentsModelList[index]
                                          .postedAt!)),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: TitleText(text: state.error!));
                  }
                },
              ),
            ),
            PrimaryButton(
                text: "Add Comment",
                onPressed: () {
                  addComment(blocContext!, context);
                })
          ],
        ),
      ),
    );
  }

  addComment(BuildContext blocContext, BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    AddContentDialog()
        .showAlert("Add Comment", "Add", context, textFieldController, formKey, () {
      if (formKey.currentState!.validate()) {
        Navigator.of(context).pop();
        blocContext.read<CommentsBloc>().add(GetAllCommentsEvent(
            content: textFieldController.text, taskId: getTaskModel!.id!));
      }
    });
  }

  updateTask(BuildContext context, ValueNotifier valueNotifier) {
    final TextEditingController textFieldController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    textFieldController.text = getTaskModel!.content!;
    AddContentDialog().showAlert(
        "Update Task",
        "Update",
        context, textFieldController, formKey, () async {
      if (formKey.currentState!.validate()) {
        Navigator.of(context).pop();
        valueNotifier.value = true;
        await ApiServiceImpl(getIt<DioService>())
            .updateTask(getTaskModel!.id!, textFieldController.text);
        valueNotifier.value = false;
        Navigator.of(context).pop(true);
      }
    });
  }

  changeStatus(String id, String status, BuildContext context) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        val.status = status;
        if (status == "done") {
          val.endDate = DateTime.now().toString();
        }
        Navigator.of(context).pop(true);
        return;
      }
    }
  }

  String getStatusByById(String id) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        return val.status!;
      }
    }
    return "";
  }

  String getCompletedDate(String id) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        return DateTimeExtension.listTileDateFormat(val.endDate!);
      }
    }
    return "";
  }

  String getStartDate(String id) {
    for (var val in hiveModelBox.values) {
      if (val.id == id) {
        return DateTimeExtension.listTileDateFormat(val.startDate!);
      }
    }
    return "";
  }
}
