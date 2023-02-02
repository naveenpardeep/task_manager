import 'package:get/get.dart';
import 'package:task_manager_app/forms/first_start/first_start_binding.dart';
import 'package:task_manager_app/forms/first_start/first_start_page.dart';
import 'package:task_manager_app/forms/invitation/acceptRejectList.dart';
import 'package:task_manager_app/forms/invitation/accept_invitation.dart';
import 'package:task_manager_app/forms/invitation/invitation_page.dart';
import 'package:task_manager_app/forms/notification/notification_page.dart';
import 'package:task_manager_app/forms/organization/create_organization.dart';
import 'package:task_manager_app/forms/organization/oraganization_userTable.dart';
import 'package:task_manager_app/forms/organization/organization_listPage.dart';
import 'package:task_manager_app/forms/organization/organization_page.dart';
import 'package:task_manager_app/forms/organization/organization_user_rowPage.dart';
import 'package:task_manager_app/forms/project/project_user_row_page.dart';
import 'package:task_manager_app/forms/task_board/task_board_page.dart';
import 'package:task_manager_app/forms/task_status/task_status_row_page.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/user_account/first_time_userAccount.dart';
import 'package:task_manager_app/forms/user_account/user_account_page.dart';
import 'package:task_manager_app/forms/user_account/user_notification_page.dart';
import 'package:task_manager_app/forms/user_account/user_profile_page.dart';
import 'package:task_manager_app/forms/user_account/user_project_list_page.dart';
import 'package:task_manager_app/splash/splash_binding.dart';
import 'package:task_manager_app/view/homepage.dart';

import 'forms/invitation/invitaion_bindings.dart';
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
      page: () => const TasksPage(),
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
      page: () => const TaskStatusPage(),
      binding: TaskStatusBinding(),
    ),
    GetPage(
      name: Routes.taskStatusListPage,
      page: () => TaskStatusListPage(),
      binding: TaskStatusBinding(),
    ),
    GetPage(
      name: Routes.homePage,
      page: () => const Homepage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.userAccount,
      page: () => const UserAccountPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.userAccountListPage,
      page: () => const UserAccountListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.taskBoard,
      page: () => const TaskBoardPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.taskrow,
      page: () => const TaskStatusRowPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectuserRowpage,
      page: () => const ProjectUserRowPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.invitationPage,
      page: () => const InvitationPage(),
      binding: InvitationBinding(),
    ),
    GetPage(
      name: Routes.organizationPage,
      page: () => const OrganizationPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.userProfilePage,
      page: () => const UserProfile(),
      binding: ProjectBinding(),
    ),
    GetPage(
        name: Routes.firstStartPage,
        page: () => FirstStartPage(),
        binding: FirstStartBinding()),
    GetPage(
      name: Routes.notificationPage,
      page: () => const NotificationPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.userNotificationNewTaskPage,
      page: () => const UserNotifictionNewTaskPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.userProjectListPage,
      page: () => const UserProjectListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.createInvitationUser,
      page: () => const CreateInvitationUserPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationListPage,
      page: () => const OrganizationListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.createOrganizationPage,
      page: () => const CreateOrganizationPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.acceptInvitationPage,
      page: () => const AcceptInvitationPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationUserRowPage,
      page: () => const OrganizationUserRowPage(),
      binding: ProjectBinding(),
    ),
     GetPage(
      name: Routes.firstTimeUserAccountPage,
      page: () => const FirstTimeUserAccountPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.acceptRejectListPage,
      page: () => const AcceptRejectListPage(),
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
  static const homePage = '/homePage';
  static const userAccount = '/userAccount';
  static const userAccountListPage = '/userAccountListPage';
  static const taskBoard = '/taskBoard';
  static const taskrow = '/taskrowpage';
  static const projectuserRowpage = '/projectUserRowPage';
  static const invitationPage = '/invitationPage';
  static const organizationPage = '/organizationPage';
  static const userProfilePage = '/userProfilePage';
  static const firstStartPage = '/firstStartPage';
  static const notificationPage = '/notificationPage';
  static const userNotificationNewTaskPage = '/userNotificationNewTaskPage';
  static const userProjectListPage = '/userProjectListPage';
  static const createInvitationUser = '/createInvitationUser';
  static const organizationListPage = '/organizationListPage';
  static const createOrganizationPage = '/createOrganizationPage';
  static const acceptInvitationPage = '/acceptInvitationPage';
  static const organizationUserRowPage = '/organizationUserRowPage';
  static const firstTimeUserAccountPage='/firstTimeUserAccountPage';
  static const acceptRejectListPage='/acceptRejectListPage';
}
