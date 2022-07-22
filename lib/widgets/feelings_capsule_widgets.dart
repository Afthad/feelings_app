import 'package:feelings_app/constants/colors.dart';
import 'package:flutter/material.dart';

import 'common_widget.dart';

class FeelingsCapsule extends StatelessWidget {
  final String emoji;
  final String percent;
  const FeelingsCapsule({Key? key, required this.emoji, required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 50,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 20.0,
                offset: const Offset(7, 0))
          ],
          color: AppColors.lightGreyColor,
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(28), top: Radius.circular(28))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          textWidget(
              text: '$percent%',
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w300),
          CircleAvatar(
            radius: 23,
            backgroundColor: AppColors.greenLightColor,
            child: textWidget(text: emoji, fontSize: 30),
          )
        ],
      ),
    );
  }
}
