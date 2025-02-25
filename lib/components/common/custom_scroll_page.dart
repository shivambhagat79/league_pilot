import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Customscrollpage extends StatefulWidget {
  final String title;
  final Widget child;
  const Customscrollpage({super.key, required this.title, required this.child});

  @override
  State<Customscrollpage> createState() => _CustomscrollpageState();
}

class _CustomscrollpageState extends State<Customscrollpage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.teal.shade900.withAlpha(190),
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.teal.shade900.withAlpha(190),
            centerTitle: true,
            pinned: true,
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontFamily: "Overcame",
                fontSize: 25,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            stretch: true,
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
          ),
          SliverToBoxAdapter(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
