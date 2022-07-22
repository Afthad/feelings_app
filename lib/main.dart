import 'package:feelings_app/routes.dart';
import 'package:feelings_app/screens/story_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      theme: ThemeData(),
      unknownRoute: GetPage(name: '/', page: () => const StoryPage()),
      getPages: AppRouter.routes,
    );
  }
}
