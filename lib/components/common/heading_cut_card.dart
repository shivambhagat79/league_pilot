import 'package:flutter/material.dart';

class HeadingCutCard extends StatelessWidget {
  final Widget child;
  final String heading;
  final Widget tail;
  const HeadingCutCard(
      {super.key,
      required this.child,
      required this.heading,
      required this.tail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.teal.shade900.withAlpha(100),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                  heading,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 22,
                      fontFamily: 'Overcame',
                      color: Colors.black.withAlpha(190)),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 45,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade900.withAlpha(100),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.surface,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade900.withAlpha(100),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
