import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Customscrollpage extends StatefulWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavigationBar;

  const Customscrollpage(
      {super.key,
      required this.title,
      required this.child,
      this.actions,
      this.floatingActionButton,
      this.bottomNavigationBar});

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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.teal.shade900.withAlpha(190),
              foregroundColor: Colors.white,
              centerTitle: true,
              // pinned: true,
              title: Text(
                widget.title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  fontSize: 22,
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
              actions: widget.actions,
            ),
            SliverToBoxAdapter(
              child: widget.child,
            ),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
