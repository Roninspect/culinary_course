// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends ConsumerWidget {
  final String text;
  final VoidCallback onpressed;
  final Color backgroundColor;
  final IconData? icon;
  final double height;
  final double width;
  const CustomButton({
    super.key,
    required this.text,
    required this.onpressed,
    required this.backgroundColor,
    this.icon,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, minimumSize: Size(width, height)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                )
              : const SizedBox.shrink(),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
