import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(5),
      width: null,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IntrinsicWidth(
        child: Row(
          children: [
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  (currentIndex == 0)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
              icon: Icon(
                Icons.home,
                size: 35,
                color: (currentIndex == 0)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                onDestinationSelected(0);
              },
            ),
            SizedBox(width: 5),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  (currentIndex == 1)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
              icon: Icon(
                Icons.sports_cricket,
                size: 35,
                color: (currentIndex == 1)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                onDestinationSelected(1);
              },
            ),
            SizedBox(width: 5),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  (currentIndex == 2)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
              icon: Icon(
                Icons.bar_chart,
                size: 35,
                color: (currentIndex == 2)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                onDestinationSelected(2);
              },
            ),
            SizedBox(width: 5),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  (currentIndex == 3)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
              icon: Icon(
                Icons.group,
                size: 35,
                color: (currentIndex == 3)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                onDestinationSelected(3);
              },
            ),
            SizedBox(width: 5),
            IconButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(15),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  (currentIndex == 4)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
              icon: Icon(
                Icons.calendar_month,
                size: 35,
                color: (currentIndex == 4)
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                onDestinationSelected(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}
