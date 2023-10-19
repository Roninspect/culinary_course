import 'package:culinary_course/src/features/auth/pages/login_page.dart';
import 'package:culinary_course/src/features/auth/pages/register_page.dart';
import 'package:culinary_course/src/features/courses/pages/course_details_page.dart';
import 'package:culinary_course/src/features/home/pages/rootpage.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/provider/user_provider.dart';

enum AppRoutes { login, register, home, course }

final routesProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userDataProvider.select((value) => value.token));
  return GoRouter(
    initialLocation: '/',
    routes: [
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
            )
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
