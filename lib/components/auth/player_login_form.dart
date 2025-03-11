import 'package:flutter/material.dart';
import 'package:hunger_games/pages/player.dart';

class PlayerLoginForm extends StatefulWidget {
  final Function toggleAuth;
  const PlayerLoginForm({super.key, required this.toggleAuth});

  @override
  State<PlayerLoginForm> createState() => _PlayerLoginFormState();
}

class _PlayerLoginFormState extends State<PlayerLoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
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
            child: Text("Login"),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?"),
            GestureDetector(
              onTap: () {
                widget.toggleAuth();
              },
              child: Text(
                " Register",
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
