import 'package:flutter/material.dart';
import 'package:todoist/widgets/button_widget.dart';
import 'package:todoist/widgets/text_widget.dart';

class AddContentDialog {
  Future<void> showAlert(
      String title,
      String primaryButtonText,
      BuildContext context,
      TextEditingController textFieldController,
      GlobalKey<FormState> formKey,
      Function? onPressed) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TitleText(text: title),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: textFieldController,
              decoration: const InputDecoration(hintText: "Enter the content"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the content';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            SecondaryButton(
                text: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            PrimaryButton(text: primaryButtonText, onPressed: onPressed),
          ],
        );
      },
    );
  }
}
