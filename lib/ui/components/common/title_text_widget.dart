import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/utils/styles/text_styles.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key, required this.title, required this.value});
  final String title;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            value ?? "-",
            style: bodyTextStyle,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Center(
          child: Text(
            title,
            style: titleTextStyle,
          ),
        ),
      ],
    );
  }
}
