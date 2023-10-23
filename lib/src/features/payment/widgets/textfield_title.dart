// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextfieldTitle extends ConsumerWidget {
  final String title;
  final bool isOptional;
  const TextfieldTitle({
    super.key,
    required this.title,
    required this.isOptional,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            isOptional
                ? const SizedBox.shrink()
                : const Text(
                    "*",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
          ],
        ),
        const SizedBox(height: 05),
      ],
    );
  }
}
