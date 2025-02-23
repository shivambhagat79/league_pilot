import 'package:flutter/material.dart';

class MatchesAppBar extends StatelessWidget {
  const MatchesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      expandedHeight: 75,
      backgroundColor: Colors.teal.shade900.withAlpha(30),
      pinned: true,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
        color: Colors.black.withAlpha(150),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
          color: Colors.black.withAlpha(150),
        ),
      ],
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0), // Moves text down slightly
        child: Text(
          "MATCHES",
          style: TextStyle(
              fontWeight: FontWeight.w100,
              fontFamily: "Overcame",
              fontSize: 25,
              color: Colors.black.withAlpha(150),
            ),
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
          /*
          child: Image.asset(
            'assets/images/components/appBar.jpg',
            fit: BoxFit.cover,
            width: double.maxFinite,
          ),
          */
        ),
      ),
    );
  }
}
