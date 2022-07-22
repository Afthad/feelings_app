import 'package:feelings_app/routes.dart';
import 'package:feelings_app/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MaterialButton(
              onPressed: () {
                Get.toNamed(Routes.feelings);
              },
              child: textWidget(text: 'Feelings History'),
            ),
            MaterialButton(
              onPressed: () {
                Get.toNamed(Routes.storyPage);
              },
              child: textWidget(text: 'StoryPage'),
            )
          ],
        ),
      ),
    );
  }
}
