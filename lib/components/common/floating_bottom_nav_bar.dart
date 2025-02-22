import 'package:flutter/material.dart';

class FloatingBottomNavBar extends StatefulWidget {
  final Function(int) onDestinationSelected;
  const FloatingBottomNavBar({super.key, required this.onDestinationSelected});

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.sports_cricket,
    Icons.scoreboard,
    Icons.calendar_month,
    Icons.group
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: SizedBox(
        height: 70.0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get the total width of this widget.
            final width = constraints.maxWidth;
            // Divide by the number of icons to find each "segment" width.
            final segmentWidth = width / _icons.length;

            // The pill is 60 wide; to center it behind an icon,
            // shift it by half of (segmentWidth - pillWidth).
            final pillLeft =
                segmentWidth * _selectedIndex + (segmentWidth - 60) / 2;

            return Stack(
              alignment: Alignment.center,
              children: [
                // The animated pill that slides behind the selected icon.
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  left: pillLeft,
                  // Center the pill vertically in a 60-height container (pill is 40 high).
                  top: (70 - 60) / 2, // = 10
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),

                // The row of icons on top.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(_icons.length, (index) {
                    final isSelected = index == _selectedIndex;
                    return IconButton(
                      icon: Icon(
                        _icons[index],
                        size: 30,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                          widget.onDestinationSelected(index);
                        });
                      },
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
