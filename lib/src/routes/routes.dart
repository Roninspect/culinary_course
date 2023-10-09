import 'package:culinary_course/src/features/auth/pages/login_page.dart';
import 'package:culinary_course/src/features/auth/pages/register_page.dart';
import 'package:culinary_course/src/features/home/pages/rootpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/provider/user_provider.dart';

enum AppRoutes { login, register, home }

final routesProvider = Provider<GoRouter>((ref) {
  final user = ref.watch(userDataProvider);
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.home.name,
        builder: (context, state) => const RootPage(),
      ),
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
      final isAuth = user.token.isNotEmpty;

      final bool isHome = state.location == '/';
      final bool isLoggingIn = state.location == '/login';
      final isRegister = state.location == '/login/register';

      if (isHome) {
        return isAuth ? '/' : "/login";
      }

      if (isLoggingIn) return isAuth ? '/' : null;

      if (isRegister) {
        if (isAuth) {
          return '/';
        } else {
          return null;
        }
      }

      return isAuth ? null : '/';
    },
  );
});
