import 'package:app_with_getx/widgets/buttons/fill_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenSettingDialog extends StatelessWidget {
  const OpenSettingDialog(
      {super.key, required this.title, this.onAffirmativeBtnPressed});

  final String title;

  final Function()? onAffirmativeBtnPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Dialog(
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text('Warning', style: theme.textTheme.headline6),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          FillButton(
            title: 'Open Setting',
            onPressed: onAffirmativeBtnPressed,
          ),
          TextButton(
            onPressed: Get.back,
            child: const Text('close'),
          )
        ],
      ),
    );
  }
}
