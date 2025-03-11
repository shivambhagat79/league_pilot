import 'package:flutter/material.dart';
import 'package:hunger_games/pages/player/player.dart';

class PlayerRegForm extends StatefulWidget {
  final Function toggleAuth;
  const PlayerRegForm({super.key, required this.toggleAuth});

  @override
  State<PlayerRegForm> createState() => _PlayerRegFormState();
}

class _PlayerRegFormState extends State<PlayerRegForm> {
  String selectedTournament = 'None';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            labelText: 'Name',
            hintText: 'Enter your Full Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            labelText: 'Phone Number',
            hintText: 'Enter your Phone Number',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        SizedBox(height: 20),
        DropdownMenu<String>(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          label: Text("Tournament"),
          hintText: "Select Tournament",
          leadingIcon: Icon(Icons.sports_esports),
          width: double.maxFinite,
          dropdownMenuEntries: [
            DropdownMenuEntry<String>(
              label: "None",
              value: 'None',
            ),
            DropdownMenuEntry<String>(
              label: "Tournament 1",
              value: 'Tournament 1',
            ),
            DropdownMenuEntry<String>(
              label: "Tournament 2",
              value: 'Tournament 2',
            ),
          ],
        ),
        SizedBox(height: 20),
        DropdownMenu<String>(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          label: Text("Contingent"),
          hintText: "Select your Contingent",
          leadingIcon: Icon(Icons.group),
          width: double.maxFinite,
          dropdownMenuEntries: [
            DropdownMenuEntry<String>(
              label: "None",
              value: 'None',
            ),
            DropdownMenuEntry<String>(
              label: "Contingent 1",
              value: 'Contingent 1',
            ),
            DropdownMenuEntry<String>(
              label: "Contingent 2",
              value: 'Contingent 2',
            ),
          ],
        ),
        SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(
            textStyle: TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerPage(),
              ),
            );
          },
          child: Container(
            height: 56,
            alignment: Alignment.center,
            width: double.maxFinite,
            child: Text("Register"),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?"),
            GestureDetector(
              onTap: () {
                widget.toggleAuth();
              },
              child: Text(
                " Login",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
