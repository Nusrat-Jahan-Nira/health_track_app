import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/utils/constants/constant_images.dart';

BoxDecoration stepCounterBoxDecorationStyle =
    const BoxDecoration(color: Colors.black, shape: BoxShape.circle);

BoxDecoration roundShapeDecorationStyle = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(imagesTitleMap[ImagesTitleEnum.roundShapeIcon]!),
    //fit: BoxFit.cover,
  ),
);
