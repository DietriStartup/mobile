import 'package:dietri/constants/fonts.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
    this.title = 'Nothing here, yet.',
    this.message = 'working on it...',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Fonts.montserratFont(
                color: Colors.black, size: 24, fontWeight: FontWeight.w500),
          ),
          const Text(
            '',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
