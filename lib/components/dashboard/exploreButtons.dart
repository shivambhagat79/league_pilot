import 'package:flutter/material.dart';

class ExploreButtons extends StatelessWidget {
  const ExploreButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 160,
      width: double.maxFinite,
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FilledButton.tonal(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.live_tv,
                            size: 24,
                          ),
                          Text(
                            "Live Events",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: FilledButton.tonal(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 24,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FilledButton.tonal(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.monetization_on_outlined,
                            size: 24,
                          ),
                          Text(
                            "Sponsors",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: FilledButton.tonal(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.group_outlined,
                            size: 24,
                          ),
                          Text(
                            "Our Team",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
