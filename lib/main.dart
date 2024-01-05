import 'package:culinary_course/src/features/auth/provider/token_provider.dart';
import 'package:culinary_course/src/features/auth/repositories/auth_repository.dart';
import 'package:culinary_course/src/routes/loading_page.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isLoading = true;
  @override
  void initState() {
    initApp();
    super.initState();
  }

  Future<void> initApp() async {
    try {
      await ref.read(authRepositoryProvider.notifier).validateAndgetUserData();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator or splash screen
      return const SizedBox.shrink();
    }
    final router = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Culinary Course',
      theme: ThemeData(useMaterial3: true),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
