import 'package:feelings_app/constants/colors.dart';
import 'package:feelings_app/constants/constants.dart';
import 'package:feelings_app/controllers/feelings_controller.dart';
import 'package:feelings_app/models/feelings.dart';
import 'package:feelings_app/widgets/common_widget.dart';
import 'package:feelings_app/widgets/feelings_capsule_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/date_chooser.dart';

class FeelingsPage extends StatefulWidget {
  const FeelingsPage({Key? key}) : super(key: key);

  @override
  State<FeelingsPage> createState() => _FeelingsPageState();
}

class _FeelingsPageState extends State<FeelingsPage> {
  final FeelingsController _controller = Get.put(FeelingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: textWidget(
              fontSize: 15,
              text: 'Your Feelings History',
              fontWeight: FontWeight.w500),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Obx(
          () => !_controller.isLoading.value
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      _buildFeelingsSection(),
                      const Divider(
                        thickness: 1,
                      ),
                      _buildFeelingsDateSelector(
                          _controller.feelings.data.feelingList),
                      const Divider(
                        thickness: 1,
                      ),
                      _buildFeelingsTimeLine(
                          _controller.feelings.data.feelingList),
                      const Divider(
                        thickness: 1,
                      ),
                      _buildBlogsSection(
                          videoArr: _controller.feelings.data.videoArr)
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }

  Widget _buildFeelingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(
              text: 'Your feelings from Last 30 Days',
              fontSize: 16,
              fontWeight: FontWeight.w300),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _controller.feelings.data.feelingList.length,
              itemBuilder: (context, index) {
                return Opacity(
                  opacity: index > 4 ? 0.4 : 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FeelingsCapsule(
                        emoji: AppConstants.getFeelingsEmoji(_controller
                            .feelings.data.feelingList[index].feelingName),
                        percent: _controller.getFeelingsPercentage(_controller
                            .feelings.data.feelingList[index].feelingName)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildBlogsSection({required List<VideoArr> videoArr}) {
    return SingleChildScrollView(
      child: Column(
        children: videoArr
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      textWidget(
                          text: e.title,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: textWidget(
                            text: e.description,
                            textAlign: TextAlign.justify,
                            fontSize: 13,
                            color: Colors.grey[600]!),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: YoutubePlayer(
                              aspectRatio: 4 / 3,
                              width: Get.width - 100,
                              controller:
                                  _controller.youTubeController(e.youtubeUrl),
                              showVideoProgressIndicator: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFeelingsDateSelector(List<FeelingList> list) {
    return Padding(
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
                        _controller.selectedDate.value.isNotEmpty
                            ? DateTime.parse(_controller.selectedDate.value)
                            : DateTime.parse(list.first.submitTime)),
                  ))),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    AppConstants.getDates(DateTime.parse(list.first.submitTime))
                        .length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: DateChooser(
                          isSelected: index == _controller.selectedIndex.value,
                          day: AppConstants.getWeekDay(AppConstants.getDates(
                                  DateTime.parse(list.first.submitTime))[index]
                              .weekday),
                          date: AppConstants.getDates(
                                  DateTime.parse(list.first.submitTime))[index]
                              .day
                              .toString(),
                          onTap: () {
                            _controller.updateDate(AppConstants.getDates(
                                        DateTime.parse(list.first.submitTime))[
                                    index]
                                .toString());

                            _controller.selectedIndex.value = index;
                          }));
                }),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingsTimeLine(List<FeelingList> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _controller
              .fiteredDateTimeList(_controller.selectedDate.value.isNotEmpty
                  ? _controller.selectedDate.value
                  : list.first.submitTime)
              .isNotEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: _controller
                      .fiteredDateTimeList(
                          _controller.selectedDate.value.isNotEmpty
                              ? _controller.selectedDate.value
                              : list.first.submitTime)
                      .map((e) => Row(
                            children: [
                              //Duration here added is 2 hours as nothing is mentioned in api
                              textWidget(
                                  fontWeight: FontWeight.w500,
                                  text:
                                      '${DateFormat('h a').format(DateTime.parse(e))} - ${DateFormat('h a').format(DateTime.parse(e).add(const Duration(hours: 2)))}'),
                              const SizedBox(
                                width: 30,
                              ),
                              textWidget(
                                  text: _controller.getFeelingForPurticularDate(
                                      _controller.selectedDate.value.isNotEmpty
                                          ? _controller.selectedDate.value
                                          : list.first.submitTime))
                            ],
                          ))
                      .toList(),
                )
              ],
            )
          : Column(children: [textWidget(text: 'No Feelings recorded')]),
    );
  }
}
