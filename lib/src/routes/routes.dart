import 'package:culinary_course/src/features/auth/pages/loading_page.dart';
import 'package:culinary_course/src/features/auth/pages/login_page.dart';
import 'package:culinary_course/src/features/auth/pages/register_page.dart';
import 'package:culinary_course/src/features/courses/pages/course_details_page.dart';
import 'package:culinary_course/src/features/enrolled-course/pages/course_playlist_page.dart';
import 'package:culinary_course/src/features/enrolled-course/pages/watch_lesson_page.dart';
import 'package:culinary_course/src/features/home/pages/rootpage.dart';
import 'package:culinary_course/src/features/payment/pages/confirm_payment.dart';
import 'package:culinary_course/src/features/search/pages/filter_page.dart';
import 'package:culinary_course/src/features/search/pages/search_page.dart';
import 'package:culinary_course/src/features/wishlist/pages/wishlist_page.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/provider/user_provider.dart';

enum AppRoutes {
  login,
  register,
  home,
  course,
  search,
  filter,
  wishlist,
  payment,
  enrolledCourse,
  lessons,
  loading
}

final routesProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userDataProvider.select((value) => value.token));

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/loading',
        name: AppRoutes.loading.name,
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
          path: '/',
          name: AppRoutes.home.name,
          builder: (context, state) => const RootPage(),
          routes: [
            GoRoute(
              path: 'courses/:id',
              name: AppRoutes.course.name,
              builder: (context, state) {
                state.pathParameters['id'];
                final Course course = state.extra as Course;
                return CourseDetailsPage(course: course);
              },
            ),
            GoRoute(
              path: 'wishlist',
              name: AppRoutes.wishlist.name,
              builder: (context, state) {
                return const WishlistPage();
              },
            ),
            GoRoute(
              path: 'payment',
              name: AppRoutes.payment.name,
              builder: (context, state) {
                return const PaymentConfirmPage();
              },
            ),
            GoRoute(
                path: 'search',
                name: AppRoutes.search.name,
                builder: (context, state) => const SearchPage(),
                routes: [
                  GoRoute(
                    path: 'filter',
                    name: AppRoutes.filter.name,
                    pageBuilder: (context, state) => MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: const FilterPage()),
                  )
                ]),
            GoRoute(
                path: 'enrolledCourse/:id',
                name: AppRoutes.enrolledCourse.name,
                builder: (context, state) {
                  state.pathParameters['id'];
                  final Course course = state.extra as Course;
                  return CoursePlaylistPage(
                    course: course,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'lessons/:lessonId',
                    name: AppRoutes.lessons.name,
                    builder: (context, state) {
                      state.pathParameters['lessonId'];
                      final Curriculum curriculum = state.extra as Curriculum;

                      return WatchLessonPage(curriculum: curriculum);
                    },
                  )
                ])
          ]),
      GoRoute(
          path: '/login',
          name: AppRoutes.login.name,
          builder: (context, state) => const LoginPage(),
          routes: [
            GoRoute(
              path: 'register',
              name: AppRoutes.register.name,
              builder: (context, state) => const RegisterPage(),
            )
          ]),
    ],
    redirect: (context, state) {
      final isAuth = user.isNotEmpty;

      final bool isHome = state.fullPath == '/';
      final bool isLoggingIn = state.fullPath == '/login';
      final isRegister = state.fullPath == '/login/register';

      if (isHome) {
        return isAuth ? null : "/login";
      }

      if (isLoggingIn) return isAuth ? '/' : null;

      if (isRegister) {
        if (isAuth) {
          return '/';
        } else {
          return null;
        }
      }

      return null;
    },
  );
});
