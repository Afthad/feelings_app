import 'package:feelings_app/screens/feelings_page.dart';
import 'package:feelings_app/screens/home.dart';
import 'package:feelings_app/screens/story_page.dart';
import 'package:get/get.dart';

class Routes {
  static const String home = '/';
  static const String feelings = '/feelingsPage';
  static const String storyPage = '/storyPage';
}

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
      name: '/',
      page: () => const Home(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/feelingsPage',
      page: () => const FeelingsPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/storyPage',
      page: () => const StoryPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
