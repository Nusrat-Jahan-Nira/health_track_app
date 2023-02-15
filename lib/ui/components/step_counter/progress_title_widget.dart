import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/utils/styles/text_styles.dart';

class ProgressTitleWidget extends StatelessWidget {
  const ProgressTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.arrow_back,
        ),
        const SizedBox(
          width: 30.0,
        ),
        Column(
          children: [
            Text(
              "Today's",
              style: progressTitleTextStyle,
            ),
            Text(
              "Progress",
              style: titleTextStyle,
            ),
            const Icon(
              Icons.arrow_drop_down_outlined,
            ),
          ],
        ),
        const SizedBox(
          width: 30.0,
        ),
        const Icon(
          Icons.arrow_forward,
        ),
      ],
    );
  }
}
