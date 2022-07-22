import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feelings_app/constants/constants.dart';
import 'package:feelings_app/models/feelings.dart';
import 'package:get/state_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeelingsController extends GetxController {
  late Response response;
  var dio = Dio();
  RxInt selectedIndex = 0.obs;
  RxString selectedDate = ''.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  late Feelings feelings;
  void getData() async {
    response = await dio.post(
        'https://www.qubehealth.com/qube_services/api/testservice/getListOfUserFeeling',
        data: {"user_id": 3206161992, "feeling_date": "15-04-2022"},
        options: Options(headers: {
          'X-Api-Key': 'f6d646a6c2f2df883ea0cccaa4097358ede98284'
        }));
    if (response.statusCode == 200) {
      feelings = Feelings.fromJson(json.decode(response.data));
      isLoading.value = false;
    }
  }

  updateDate(String date) {
    selectedDate.value = date;
  }

  String getFeelingsPercentage(String feeling) {
    String percentage = '0';
    (feelings.data.feelingPercentage.toJson()).forEach((key, value) {
      if (feeling == key) {
        percentage = value;
      }
    });
    return percentage;
  }

  List<String> fiteredDateTimeList(String selectedDate) {
    List<String> fiteredDateTimeList = [];
    for (var e in feelings.data.feelingList) {
      if (DateTime(
                  DateTime.parse(e.submitTime).year,
                  DateTime.parse(e.submitTime).month,
                  DateTime.parse(e.submitTime).day)
              .millisecondsSinceEpoch ==
          DateTime(
                  DateTime.parse(selectedDate).year,
                  DateTime.parse(selectedDate).month,
                  DateTime.parse(selectedDate).day)
              .millisecondsSinceEpoch) {
        fiteredDateTimeList.add(e.submitTime);
      }
    }
    return fiteredDateTimeList;
  }

  String getFeelingForPurticularDate(String date) {
    String feeling = '';
    for (var e in feelings.data.feelingList) {
      if (DateTime(
                  DateTime.parse(e.submitTime).year,
                  DateTime.parse(e.submitTime).month,
                  DateTime.parse(e.submitTime).day)
              .millisecondsSinceEpoch ==
          DateTime(DateTime.parse(date).year, DateTime.parse(date).month,
                  DateTime.parse(date).day)
              .millisecondsSinceEpoch) {
        feeling = e.feelingName;
      }
    }
    return AppConstants.getFeelingsEmoji(feeling) + feeling;
  }

  YoutubePlayerController youTubeController(String url) {
    String? videoId;
    videoId = YoutubePlayer.convertUrlToId(url);
    return YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }
}
