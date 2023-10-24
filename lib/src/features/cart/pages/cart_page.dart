import 'package:cached_network_image/cached_network_image.dart';
import 'package:culinary_course/src/core/constants/colors.dart';
import 'package:culinary_course/src/core/widgets/custom_button.dart';
import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:culinary_course/src/features/cart/controller/cart_controller.dart';
import 'package:culinary_course/src/models/course.dart';
import 'package:culinary_course/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Course> cartList =
        ref.watch(userDataProvider.select((value) => value.cart));

    bool isLoading = ref.watch(cartControllerProvider);

    num getTotalPrice() {
      num total = 0;

      for (var cart in cartList) {
        total = cart.price + total;
      }

      return double.parse(total.toStringAsFixed(2));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total courses (${cartList.length})",
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        final cart = cartList[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () => context.pushNamed(
                                AppRoutes.course.name,
                                pathParameters: {'id': cart.id},
                                extra: cart),
                            tileColor: const Color.fromARGB(255, 231, 229, 229),
                            contentPadding: EdgeInsets.zero,
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 10,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: cart.thumbnail,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(cart.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text(cart.instructor.instructorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "\$${cart.price}",
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(cartControllerProvider.notifier)
                                        .removeFromCart(
                                            courseId: cart.id,
                                            course: cart,
                                            context: context,
                                            ref: ref);
                                  },
                                  icon:
                                      const Icon(Icons.close_rounded, size: 20),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: SizedBox(
        width: 365,
        child: CustomButton(
            height: 50,
            width: 10,
            text: "Checkout \$${getTotalPrice()}",
            onpressed: () {
              context.pushNamed(AppRoutes.payment.name);
            },
            backgroundColor: primaryColor),
      ),
    );
  }
}
