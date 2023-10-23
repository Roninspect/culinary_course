import 'package:culinary_course/src/features/auth/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameAvatarWidget extends ConsumerWidget {
  const NameAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userDataProvider.select((value) => value.name));
    final isPaidUser =
        ref.watch(userDataProvider.select((value) => value.isPaid));
    final email = ref.watch(userDataProvider.select((value) => value.email));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  !isPaidUser
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: const BoxDecoration(
                                color: Color(0xffC3EFBF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              "PRO",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ))
                      : const SizedBox.shrink(),
                ],
              ),
              Text(
                email,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: CircleAvatar(
            backgroundColor: Color(0xffFFC86F),
            radius: 30,
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
