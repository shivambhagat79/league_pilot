import 'package:flutter/material.dart';

class DashboardContacts extends StatelessWidget {
  const DashboardContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal.shade900.withAlpha(230),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Contact us",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Overcame",
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        color: Colors.blue.shade900,
                      ),
                      Text(
                        " Organising Team:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("   +91 9876543210", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: Colors.teal.shade900,
                      ),
                      Text(
                        " Medical Assistance:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("   +91 9876543210", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Colors.red.shade900,
                      ),
                      Text(
                        " Security:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("   +91 9876543210", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Colors.deepPurple.shade900,
                      ),
                      Text(
                        " Email:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text("   tournament@leaguepilot.com",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
