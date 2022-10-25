import 'package:get/get.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';

import 'forms/project/project_binding.dart';
import 'forms/project/project_list_page.dart';
import 'forms/project/project_page.dart';
import 'forms/tasks/tasks_binding.dart';
import 'forms/tasks/tasks_list_page.dart';
import 'forms/tasks/tasks_page.dart';
import 'splash/splash_binding.dart';
import 'splash/splash_page.dart';
import 'start_page.dart';

class AppPages {
  static const initial = Routes.splashPage;

  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splashPage,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.mainPage,
      page: () => const StartPage(),
      //binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.tasksListPage,
      page: () => TasksListPage(),
      binding: TasksListBinding(),
    ),
    GetPage(
      name: Routes.tasksPage,
      page: () => TasksPage(),
      binding: TasksListBinding(),
    ),
    GetPage(
      name: Routes.projectListPage,
      page: () => ProjectListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectPage,
      page: () => ProjectPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.commentRowPage,
      page: () => TasksCommentRowPage(),
      binding: TasksListBinding(),
    ),
  ];
}

abstract class Routes {
  static const splashPage = '/';
  static const mainPage = '/main';
  static const tasksListPage = '/tasksListPage';
  static const tasksPage = '/tasksPage';
  static const projectListPage = '/projectListPage';
  static const projectPage = '/projectPage';
  static const commentRowPage = '/commentRowPage';
}
