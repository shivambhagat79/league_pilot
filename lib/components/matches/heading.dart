import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  const Heading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 2,
            width: 50,
            margin: const EdgeInsets.only(right: 10),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 2,
            width: 50,
            margin: const EdgeInsets.only(left: 10),
          ),
        ],
      ),
    );
  }
}
