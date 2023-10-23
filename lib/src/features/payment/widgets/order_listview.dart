import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/cart/controller/cart_controller.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderListview extends ConsumerStatefulWidget {
  const OrderListview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderListviewState();
}

class _OrderListviewState extends ConsumerState<OrderListview> {
  late GoRouter _navigator;

  @override
  void didChangeDependencies() {
    _navigator = GoRouter.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(cartControllerProvider);
    final cart = ref.watch(userDataProvider.select((value) => value.cart));
    return SizedBox(
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final course = cart[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    onTap: () => context.pushNamed(AppRoutes.course.name,
                        pathParameters: {'id': course.id}, extra: course),
                    tileColor: const Color.fromARGB(255, 231, 229, 229),
                    contentPadding: EdgeInsets.zero,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: course.thumbnail,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    title: Text(course.title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(course.instructor.instructorName,
                        style: const TextStyle(fontWeight: FontWeight.w500)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "\$${course.price}",
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (cart.length == 1) {
                              await ref
                                  .read(cartControllerProvider.notifier)
                                  .removeFromCart(
                                      courseId: course.id,
                                      course: course,
                                      context: context,
                                      ref: ref);

                              if (mounted) {
                                _navigator.pop();
                              }
                            } else {
                              ref
                                  .read(cartControllerProvider.notifier)
                                  .removeFromCart(
                                      courseId: course.id,
                                      course: course,
                                      context: context,
                                      ref: ref);
                            }
                          },
                          icon: const Icon(Icons.close_rounded, size: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
