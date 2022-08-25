import 'package:go_router/go_router.dart';

import '../../_core/router/go_routes.dart';
import 'views/create_profile/pages/add_area_of_work_page.dart';
import 'views/create_profile/pages/add_basic_profile_page.dart';
import 'views/create_profile/pages/add_bio_page.dart';
import 'views/create_profile/pages/add_education_page.dart';
import 'views/create_profile/pages/add_experience_page.dart';
import 'views/create_profile/pages/add_expertise_page.dart';
import 'views/create_profile/pages/add_language_page.dart';
import 'views/create_profile/pages/add_skills_page.dart';
import 'views/create_profile/pages/create_profile_start_page.dart';
import 'views/create_profile/pages/create_profile_wrapper_page.dart';
import 'views/forget_password/pages/forget_password_page.dart';
import 'views/sign_in/page/sign_in_page.dart';
import 'views/sign_up/pages/sign_up_page.dart';
import 'views/verify_email/pages/verify_email_page.dart';
import 'views/view_profile/pages/profile_page.dart';

const String viewProfileRouteName = 'view-profile';
const String loginRouteName = 'login';
const String verifyRouteName = 'verify';
const String forgetPasswordRouteName = 'forget-password';
const String createAccountRouteName = 'create-account';
//! ************
const String createProfileRouteName = 'create-profile';
const String createProfileExpertiseRouteName = 'create-profile-expertise';
const String createProfileExperienceRouteName = 'create-profile-experience';
const String createProfileEducationRouteName = 'create-profile-education';
const String createProfileLanguageRouteName = 'create-profile-language';
const String createProfileSkillRouteName = 'create-profile-skill';
const String createProfileBioRouteName = 'create-profile-bio';
const String createProfileAreaOfWorkRouteName = 'create-profile-area-of-work';
const String createProfileBasicProfileRouteName =
    'create-profile-basic-profile';
const String createProfileCheckProfileRouteName =
    'create-profile-check-profile';

final List<GoRoute> userRoutes = [
  GoRoute(
    name: loginRouteName,
    path: '/login',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const SignInPage(),
    ),
  ),
  GoRoute(
    name: verifyRouteName,
    path: '/verify',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const VerifyEmailPage(),
    ),
  ),
  GoRoute(
    name: forgetPasswordRouteName,
    path: '/forget-password',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const ForgetPasswordPage(),
    ),
  ),
  GoRoute(
    name: createAccountRouteName,
    path: '/create-account',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const SignUpPage(),
    ),
  ),
  GoRoute(
    name: createProfileRouteName,
    path: '/create-profile',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: CreateProfileStartPage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileExpertiseRouteName,
    path: '/create-profile/add-expertise',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddExpertisePage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileExperienceRouteName,
    path: '/create-profile/add-experience',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddExperiencePage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileEducationRouteName,
    path: '/create-profile/add-education',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddEducationPage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileLanguageRouteName,
    path: '/create-profile/add-language',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddLanguagePage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileSkillRouteName,
    path: '/create-profile/add-skill',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddSkillsPage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileBioRouteName,
    path: '/create-profile/add-bio',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddBioPage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileAreaOfWorkRouteName,
    path: '/create-profile/add-area-of-work',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: AddAreaOfWorkPage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileBasicProfileRouteName,
    path: '/create-profile/add-basic-profile',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: CreateProfileWrapperPage(
        child: AddBasicProfilePage(),
      ),
    ),
  ),
  GoRoute(
    name: createProfileCheckProfileRouteName,
    path: '/create-profile/check-profile',
    pageBuilder: (context, state) => FadeTransitionPage(
      key: state.pageKey,
      child: const CreateProfileWrapperPage(
        child: ViewProfilePage(),
      ),
    ),
  ),
];


