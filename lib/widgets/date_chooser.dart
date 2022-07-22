import 'package:feelings_app/constants/colors.dart';
import 'package:feelings_app/widgets/common_widget.dart';
import 'package:flutter/material.dart';

class DateChooser extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final Function() onTap;

  const DateChooser({
    Key? key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          width: 50,
          decoration: BoxDecoration(
              color: isSelected ? AppColors.darkGreyColor : Colors.white,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              textWidget(
                  text: day,
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              const SizedBox(
                height: 5,
              ),
              textWidget(
                  text: date,
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w300)
            ],
          ),
        ),
      ),
    );
  }
}
