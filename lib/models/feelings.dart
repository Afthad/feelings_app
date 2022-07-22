class Feelings {
  Feelings({
    required this.data,
  });

  Data data;

  factory Feelings.fromJson(Map<String, dynamic> json) => Feelings(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.feelingPercentage,
    required this.feelingList,
    required this.videoArr,
  });

  FeelingPercentage feelingPercentage;
  List<FeelingList> feelingList;
  List<VideoArr> videoArr;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        feelingPercentage:
            FeelingPercentage.fromJson(json["feeling_percentage"]),
        feelingList: List<FeelingList>.from(
            json["feeling_list"].map((x) => FeelingList.fromJson(x))),
        videoArr: List<VideoArr>.from(
            json["video_arr"].map((x) => VideoArr.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "feeling_percentage": feelingPercentage.toJson(),
        "feeling_list": List<dynamic>.from(feelingList.map((x) => x.toJson())),
        "video_arr": List<dynamic>.from(videoArr.map((x) => x.toJson())),
      };
}

class FeelingList {
  FeelingList({
    required this.userFeelingId,
    required this.feelingId,
    required this.feelingName,
    required this.submitTime,
  });

  String userFeelingId;
  String feelingId;
  String feelingName;
  String submitTime;

  factory FeelingList.fromJson(Map<String, dynamic> json) => FeelingList(
        userFeelingId: json["user_feeling_id"],
        feelingId: json["feeling_id"],
        feelingName: json["feeling_name"],
        submitTime: json["submit_time"],
      );

  Map<String, dynamic> toJson() => {
        "user_feeling_id": userFeelingId,
        "feeling_id": feelingId,
        "feeling_name": feelingName,
        "submit_time": submitTime,
      };
}

class FeelingPercentage {
  FeelingPercentage({
    required this.happy,
    required this.sad,
    required this.energetic,
    required this.calm,
    required this.angry,
    required this.bored,
  });

  String happy;
  String sad;
  String energetic;
  String calm;
  String angry;
  String bored;

  factory FeelingPercentage.fromJson(Map<String, dynamic> json) =>
      FeelingPercentage(
        happy: json["Happy"],
        sad: json["Sad"],
        energetic: json["Energetic"],
        calm: json["Calm"],
        angry: json["Angry"],
        bored: json["Bored"],
      );

  Map<String, dynamic> toJson() => {
        "Happy": happy,
        "Sad": sad,
        "Energetic": energetic,
        "Calm": calm,
        "Angry": angry,
        "Bored": bored,
      };
}

class VideoArr {
  VideoArr({
    required this.title,
    required this.description,
    required this.youtubeUrl,
  });

  String title;
  String description;
  String youtubeUrl;

  factory VideoArr.fromJson(Map<String, dynamic> json) => VideoArr(
        title: json["title"],
        description: json["description"],
        youtubeUrl: json["youtube_url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "youtube_url": youtubeUrl,
      };
}
