import 'package:feelings_app/constants/colors.dart';
import 'package:feelings_app/constants/constants.dart';
import 'package:feelings_app/controllers/feelings_controller.dart';
import 'package:feelings_app/widgets/common_widget.dart';
import 'package:feelings_app/widgets/feelings_capsule_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/date_chooser.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  List<Map> values = [
    {'name': "Bored", "percent": "70"},
    {'name': "Sad", "percent": "80"},
    {'name': "Bored", "percent": "30"}
  ];
  final FeelingsController _controller = Get.put(FeelingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return !_controller.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: textWidget(text: 'HI', textAlign: TextAlign.left),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: values.length,
                        itemBuilder: (context, index) {
                          return Opacity(
                            opacity: index > 1 ? 0.4 : 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FeelingsCapsule(
                                  emoji: AppConstants.getFeelingsEmoji(
                                      values[index]['name']),
                                  percent: values[index]['percent']),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blueLightColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: textWidget(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    text: DateFormat.yMMMMd('en_US').format(
                                        _controller
                                                .selectedDate.value.isNotEmpty
                                            ? DateTime.parse(
                                                _controller.selectedDate.value)
                                            : DateTime.parse(_controller
                                                .feelings
                                                .data
                                                .feelingList
                                                .first
                                                .submitTime)),
                                  ))),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: AppConstants.getDates(DateTime.parse(
                                        _controller.feelings.data.feelingList
                                            .first.submitTime))
                                    .length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: DateChooser(
                                          isSelected: index ==
                                              _controller.selectedIndex.value,
                                          day: AppConstants.getWeekDay(AppConstants.getDates(
                                                  DateTime.parse(_controller
                                                      .feelings
                                                      .data
                                                      .feelingList
                                                      .first
                                                      .submitTime))[index]
                                              .weekday),
                                          date: AppConstants.getDates(
                                                  DateTime.parse(_controller
                                                      .feelings
                                                      .data
                                                      .feelingList
                                                      .first
                                                      .submitTime))[index]
                                              .day
                                              .toString(),
                                          onTap: () {
                                            _controller.updateDate(AppConstants
                                                    .getDates(DateTime.parse(
                                                        _controller
                                                            .feelings
                                                            .data
                                                            .feelingList
                                                            .first
                                                            .submitTime))[index]
                                                .toString());

                                            _controller.selectedIndex.value =
                                                index;
                                          }));
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
