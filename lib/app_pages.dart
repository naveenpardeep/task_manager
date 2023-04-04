import 'package:get/get.dart';
import 'package:task_manager_app/forms/first_start/first_start_binding.dart';
import 'package:task_manager_app/forms/first_start/first_start_page.dart';
import 'package:task_manager_app/forms/invitation/acceptRejectList.dart';
import 'package:task_manager_app/forms/invitation/accept_invitation.dart';
import 'package:task_manager_app/forms/invitation/invitationAcceptNew.dart';
import 'package:task_manager_app/forms/invitation/invitation_page.dart';
import 'package:task_manager_app/forms/notification/notification_page.dart';
import 'package:task_manager_app/forms/organization/create_organization.dart';
import 'package:task_manager_app/forms/organization/new_orgUser_for_deletedUser.dart';
import 'package:task_manager_app/forms/organization/oraganization_userTable.dart';
import 'package:task_manager_app/forms/organization/organization_listPage.dart';
import 'package:task_manager_app/forms/organization/organization_list_mobileView.dart';
import 'package:task_manager_app/forms/organization/organization_page.dart';
import 'package:task_manager_app/forms/organization/organization_projects.dart';
import 'package:task_manager_app/forms/organization/organization_userProfile.dart';
import 'package:task_manager_app/forms/organization/organization_user_add_page.dart';
import 'package:task_manager_app/forms/organization/organization_user_rowPage.dart';
import 'package:task_manager_app/forms/organization/organization_users_Mobile.dart';
import 'package:task_manager_app/forms/organization/organization_viewPage_Mobile.dart';
import 'package:task_manager_app/forms/project/add_user_to_Project.dart';
import 'package:task_manager_app/forms/project/new_user_for_deletedUser.dart';
import 'package:task_manager_app/forms/project/projectUserMobile.dart';
import 'package:task_manager_app/forms/project/project_edit_page.dart';
import 'package:task_manager_app/forms/project/project_settings.dart';
import 'package:task_manager_app/forms/project/project_status_page.dart';
import 'package:task_manager_app/forms/project/project_userViewpage.dart';
import 'package:task_manager_app/forms/project/project_user_row_page.dart';
import 'package:task_manager_app/forms/project/project_Mobileview_page.dart';
import 'package:task_manager_app/forms/project/projectboardMobile.dart';
import 'package:task_manager_app/forms/task_board/taskBoard_status.dart';
import 'package:task_manager_app/forms/task_board/task_board_page.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/task_status/task_status_row_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/edit_checklist.dart';
import 'package:task_manager_app/forms/tasks/edit_commentPage.dart';
import 'package:task_manager_app/forms/tasks/new_task_page.dart';
import 'package:task_manager_app/forms/tasks/notification_TaskPage.dart';
import 'package:task_manager_app/forms/tasks/task_checklist_page.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/user_account/first_time_userAccount.dart';
import 'package:task_manager_app/forms/user_account/profile_ViewPage.dart';
import 'package:task_manager_app/forms/user_account/profile_edit_page.dart';
import 'package:task_manager_app/forms/user_account/user_account_page.dart';
import 'package:task_manager_app/forms/user_account/user_notification_page.dart';
import 'package:task_manager_app/forms/user_account/user_profile_page.dart';
import 'package:task_manager_app/forms/user_account/user_project_list_page.dart';
import 'package:task_manager_app/login/login_confirm_page.dart';
import 'package:task_manager_app/login/start_page.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/splash/splash_binding.dart';
import 'package:task_manager_app/view/homepage.dart';
import 'package:task_manager_app/view/taskview.dart';

import 'forms/invitation/invitaion_bindings.dart';
import 'forms/project/project_binding.dart';
import 'forms/project/project_list_page.dart';
import 'forms/task_comment/task_comment_binding.dart';
import 'forms/task_status/task_status_binding.dart';
import 'forms/task_status/task_status_list_page.dart';
import 'forms/task_status/task_status_page.dart';
import 'forms/tasks/tasks_binding.dart';
import 'forms/tasks/tasks_list_page.dart';
import 'forms/tasks/tasks_page.dart';
import 'forms/user_account/user_account_listpage.dart';
import 'old_start_page.dart';
import 'splash/splash_page.dart';

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
      page: () => const StartPageOld(),
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
      name: Routes.projectSettingsPage,
      page: () => const ProjectSettings(),
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
    GetPage(name: Routes.firstStartPage, page: () => FirstStartPage(), binding: FirstStartBinding()),
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
      page: () => CreateOrganizationPage(),
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
      page: () => FirstTimeUserAccountPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.acceptRejectListPage,
      page: () => const AcceptRejectListPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.addUserToProjectPage,
      page: () => const AddUserToProjectPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.editCommentPage,
      page: () => const EditCommentPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.taskChecklistPage,
      page: () => const TaskChecklistPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.newTaskPage,
      page: () => const NewTaskPage(),
      binding: TasksListBinding(),
    ),
    GetPage(
      name: Routes.checkListPage,
      page: () => const ChecklistPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.editChecklistPage,
      page: () => const EditChecklistPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.taskViewPage,
      page: () => const TaskViewPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectMobilePageview,
      page: () => const ProjectMobileViewPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectEditPage,
      page: () => const ProjectEditPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectBoardMobile,
      page: () => const ProjectBoardMobile(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectUserMobile,
      page: () => const ProjectUserMobile(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.projectUserViewPage,
      page: () => const ProjectUserViewPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.taskBoardStatusPage,
      page: () => const TaskBoardStatusPage(),
      binding: ProjectBinding(),
    ),
    GetPage(name: Routes.projectStatusPage, page: () => const ProjectStatusPage()),
    GetPage(
      name: Routes.startPage,
      page: () => StartPage(),
      binding: ProjectBinding(),
    ),
    GetPage(name: Routes.loginConfirmPage, page: () => const LoginConfirmPage(), binding: ProjectBinding()),
    GetPage(
      name: Routes.organizationListMobilePage,
      page: () => const OrganizationListMobileView(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationViewPageMobile,
      page: () => const OrganizationViewPageMobile(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationUsersMobilePage,
      page: () => const OrganizationUsersMobilePage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationUserAddPage,
      page: () => const OrganizationUserAddPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationUserProfile,
      page: () => const OrganizationUserProfile(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.organizationPage,
      page: () => OrganizationProject(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.invitationAcceptNew,
      page: () => const InvitationAcceptNew(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.profileViewPage,
      page: () => const ProfileViewPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.profileEditPage,
      page: () => ProfileEditPage(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: Routes.notificationTaskPage,
      page: () => const NotificationTasksPage(),
      binding: TasksListBinding(),
    ),
     GetPage(
      name: Routes.taskcommentpage,
      page: () => const TasksCommentPage(),
      binding: TaskCommentBinding(),
    ),
     GetPage(
      name: Routes.newUserForDeletedUserPage,
      page: () =>const NewUserForDeletedUserPage(),
      binding: ProjectBinding(),
    ),
     GetPage(
      name: Routes.newOrgUserForDeletedUserPage,
      page: () =>const NewOrgUserForDeletedUserPage(),
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
  static const projectSettingsPage = '/projectSettingsPage';
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
  static const firstTimeUserAccountPage = '/firstTimeUserAccountPage';
  static const acceptRejectListPage = '/acceptRejectListPage';
  static const addUserToProjectPage = '/addUserToProjectPage';
  static const editCommentPage = '/editCommentPage';
  static const taskChecklistPage = '/TaskChecklistPage';
  static const newTaskPage = '/newTaskPage';
  static const checkListPage = '/checkListPage';
  static const taskViewPage = '/taskViewPage';
  static const editChecklistPage = '/editCHecklistPage';
  static const projectMobilePageview = '/projectMobilePageView';
  static const projectEditPage = '/projectEditPage';
  static const projectBoardMobile = '/projectBoardMobile';
  static const projectUserMobile = '/projectUserMobile';
  static const projectUserViewPage = '/projectUserviewPage';
  static const taskBoardStatusPage = '/taskBoardStatusPage';
  static const projectStatusPage = '/projectStatusPage';

  static const loginConfirmPage = '/loginConfirmPage';
  static const startPage = '/start-page';
  static const organizationListMobilePage = '/organizationListMobile';
  static const organizationViewPageMobile = '/OrganizationViewPageMobile';
  static const organizationUsersMobilePage = '/OrganizationUsersMobilePage';
  static const organizationUserAddPage = '/OrganizationUserAddPage';
  static const organizationUserProfile = '/OrganizationUserProfile';
  static const organizationProject = '/organizationProject';
  static const invitationAcceptNew = '/invitationAcceptNew';
  static const profileViewPage = '/profileViewPage';
  static const profileEditPage = '/profile-edit-page';
  static const notificationTaskPage = '/notificationTaskPage';
  static const taskcommentpage='/taskcommetpage';
  static const newUserForDeletedUserPage='/newUserForDeletedUserPage';
  static const newOrgUserForDeletedUserPage='/newOrgUserForDeletedUserPage';
}
