import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todoist/blocs/comments_bloc/comments_bloc.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/utils/app_colors.dart';
import 'package:todoist/utils/date_time_extension.dart';
import 'package:todoist/utils/get_it_setup.dart';
import 'package:todoist/widgets/add_content_dialog.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class TaskViewScreen extends StatelessWidget {
  final GetTaskModel? getTaskModel;

  const TaskViewScreen({super.key, this.getTaskModel});

  @override
  Widget build(BuildContext context) {
    BuildContext? blocContext;
    return Scaffold(
      appBar: AppBar(
        title: const PrimaryButtonText(text: "Task Details"),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(
            color: AppColors.whiteColor
        ),
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
                  const TitleText(text: "Content: "),
                  LabelText(text: getTaskModel!.content!,),
                  const Gap(20),
                  TitleText(text: "Comments: ${getTaskModel!.commentCount ?? 0}"),
                ],
              ),
            ),
            BlocProvider(
              create: (context) =>
              CommentsBloc(getIt<ApiServices>())
                ..add(GetAllCommentsEvent(taskId: getTaskModel!.id!)),
              child: BlocConsumer<CommentsBloc, CommentsState>(
                listener: (context, state) {
                },
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
                                  text: state.allCommentsModelList[index].content!),
                              leading: const Icon(Icons.task),
                              subtitle: BodyText(
                                  text: DateTimeExtension.listTileDateFormat(
                                      state.allCommentsModelList[index].postedAt!)),
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

    AddContentDialog().showAlert(context, textFieldController, formKey, () {
      if (formKey.currentState!.validate()) {
        Navigator.of(context).pop();
        blocContext
            .read<CommentsBloc>()
            .add(GetAllCommentsEvent(content: textFieldController.text, taskId: getTaskModel!.id!));
      }
    });
  }
}
