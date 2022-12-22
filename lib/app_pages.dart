import 'package:get/get.dart';
import 'package:task_manager_app/forms/task_board/task_board_page.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/user_account/user_account_page.dart';
import 'package:task_manager_app/model/task_board.dart';
import 'package:task_manager_app/model/user_account.dart';
import 'package:task_manager_app/view/homepage.dart';

import 'forms/project/project_binding.dart';
import 'forms/project/project_list_page.dart';
import 'forms/project/project_page.dart';
import 'forms/task_status/task_status_binding.dart';
import 'forms/task_status/task_status_list_page.dart';
import 'forms/task_status/task_status_page.dart';
import 'forms/tasks/tasks_binding.dart';
import 'forms/tasks/tasks_list_page.dart';
import 'forms/tasks/tasks_page.dart';
import 'forms/user_account/user_account_listpage.dart';
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
      page: () =>  TasksPage(),
      binding: TasksListBinding(),
    ),
    GetPage(
      name: Routes.projectListPage,
      page: () => ProjectListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectPage,
      page: () => const ProjectPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.commentRowPage,
      page: () => const TasksCommentRowPage(),
      binding: TasksListBinding(),
    ),
    GetPage(
      name: Routes.taskStatusPage,
      page: () =>  TaskStatusPage(),
      binding: TaskStatusBinding(),
    ),
    GetPage(
      name: Routes.taskStatusListPage,
      page: () => TaskStatusListPage(),
      binding: TaskStatusBinding(),
    ),
    GetPage(
      name: Routes.homePage,
      page: () => Homepage(),
      binding: ProjectBinding(), 
    ),
     GetPage(
      name: Routes.userAccount,
      page: () => UserAccountPage(),
      binding: ProjectBinding(), 
    ),
     GetPage(
      name: Routes.userAccountListPage,
      page: () => UserAccountListPage(),
      binding: ProjectBinding(), 
    ),
       GetPage(
      name: Routes.taskBoard,
      page: () => TaskBoardPage(),
      binding: ProjectBinding(), 
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
  static const taskStatusListPage = '/taskStatusListPage';
  static const taskStatusPage = '/taskStatusPage';
  static const homePage='/homePage';
  static const userAccount='/userAccount';
  static const userAccountListPage='/userAccountListPage';
  static const taskBoard='/taskBoard';
}
