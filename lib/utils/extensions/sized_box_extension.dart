import 'package:flutter/cupertino.dart';

extension SizedBoxExtension on num {
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get wh => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );
}
