import 'package:flutter/material.dart';
import 'package:test_app/utils/constants.dart';

Widget appLoadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      color: appDefaultColor,
    ),
  );
}

