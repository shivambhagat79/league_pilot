import 'package:flutter/material.dart';

class DashboardActions extends StatelessWidget {
  const DashboardActions({super.key});
  void onPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade900.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            child: Text(
              "Dashboard Actions",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Overcame",
                color: Colors.black.withAlpha(190),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: "Live Events",
                  onPressed: onPressed,
                  icon: Icon(Icons.live_tv),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ActionButton(
                  text: "Essential Info",
                  onPressed: onPressed,
                  icon: Icon(Icons.info),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: "Our Team",
                  onPressed: onPressed,
                  icon: Icon(Icons.group),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ActionButton(
                  text: "Sponsors",
                  onPressed: onPressed,
                  icon: Icon(Icons.attach_money),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Icon icon;
  const ActionButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon,
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  // fontFamily: "Overcame",
                  color: Colors.black.withAlpha(190),
                ),
              ),
            ],
          ),
        ));
  }
}
