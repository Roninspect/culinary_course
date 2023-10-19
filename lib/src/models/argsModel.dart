import 'package:flutter/material.dart';

class ArgsModel {
  final String firstParams;
  final BuildContext secondParams;

  const ArgsModel({required this.firstParams, required this.secondParams});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArgsModel &&
          other.runtimeType == runtimeType &&
        other.firstParams == firstParams &&
        other.secondParams == secondParams;
  }

  @override
  int get hashCode => firstParams.hashCode ^ secondParams.hashCode;
}
