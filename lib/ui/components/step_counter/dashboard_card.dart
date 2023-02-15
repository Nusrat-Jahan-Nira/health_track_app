import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_track_app/ui/components/common/text.dart';
import 'package:health_track_app/ui/components/step_counter/container_button.dart';
import 'package:health_track_app/ui/components/step_counter/image_ontainer.dart';

class dashboardCard extends StatelessWidget {
  int steps;
  double miles, calories, duration;
  dashboardCard(this.steps, this.miles, this.calories, this.duration,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xff1D3768),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // this is botton part
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                imageContainer(
                    "assets/locations.png", miles.toStringAsFixed(3), "Miles"),
                imageContainer("assets/calories.png",
                    calories.toStringAsFixed(3), "Calories"),
                imageContainer("assets/stopwatch.png",
                    duration.toStringAsFixed(3), "Duration"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
