import 'package:flutter/material.dart';

class MatchesAppBar extends StatelessWidget {
  const MatchesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 200,
      backgroundColor: Theme.of(context).colorScheme.primary,
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      title: Text(
        "MATCHES",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(20),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
          child: Image.asset(
            'assets/images/components/appBar.jpg',
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
