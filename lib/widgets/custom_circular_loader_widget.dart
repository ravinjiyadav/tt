
import 'package:book_your_truck/utilities/color_utility.dart' show ColorUtility;
import 'package:flutter/material.dart';

import '../utilities/style_utility.dart';

class CustomCircularLoaderWidget extends StatelessWidget {
  const CustomCircularLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: ColorUtility.colorEA580C,
      ),
    );
  }
}



class NoDataWidget extends StatelessWidget {
  final String? message;
  final double iconSize;
  final double spacing;

  const NoDataWidget({
    super.key,
    this.message,
    this.iconSize = 80,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: iconSize,
            color: Colors.grey[400],
          ),
          SizedBox(height: spacing),
          Text(
              message ?? 'No data found',
              style: StyleUtility.manropeMedium16Color1E1E2D
          ),
        ],
      ),
    );
  }
}

