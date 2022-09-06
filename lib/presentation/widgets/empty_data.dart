import 'package:flutter/material.dart';
import 'package:hash_micro_test/core/config/app_typography.dart';
import 'package:hash_micro_test/core/config/icons_string.dart';
import 'package:hash_micro_test/presentation/widgets/app_text.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            IconString.icEmpty,
            height: 48,
          ),
          const SizedBox(height: 16),
          AppText(
            title: "Data is empty or not found",
            textStyle: AppTypography.body1(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
