import 'package:flutter/material.dart';
import 'package:hunger_games/pages/player/player.dart';
import 'package:hunger_games/services/auth.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class PlayerLoginForm extends StatefulWidget {
  final Function toggleAuth;
  const PlayerLoginForm({super.key, required this.toggleAuth});

  @override
  State<PlayerLoginForm> createState() => _PlayerLoginFormState();
}

class _PlayerLoginFormState extends State<PlayerLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      List<String?> result = await _authService.loginPlayer(email, password);

      setState(() {
        _isLoading = false;
      });

      if (result[0] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result[1]!,
              textAlign: TextAlign.center,
            ),
          ),
        );
        return;
      } else {
        await savePlayerLoginState(true);
        await savePlayerEmail(email);
        await savePlayerId(result[0]!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login successful",
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerPage(playerEmail: email),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _handleLogin,
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
            ),
          );
  }
}
