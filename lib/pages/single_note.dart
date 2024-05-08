import 'package:brainbox/models/note_model.dart';
import 'package:brainbox/utils/colors.dart';
import 'package:brainbox/utils/constants.dart';
import 'package:brainbox/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SingleNotePage extends StatelessWidget {
  final Note note;
  const SingleNotePage({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              note.title,
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(height: 20),
            Text(
              note.content,
              style: AppTextStyles.appDescription.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
