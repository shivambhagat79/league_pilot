import 'package:flutter/material.dart';
import 'package:hunger_games/pages/player/player.dart';
import 'package:hunger_games/services/auth.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class ScorekeeperRegForm extends StatefulWidget {
  final Function toggleAuth;
  const ScorekeeperRegForm({super.key, required this.toggleAuth});

  @override
  State<ScorekeeperRegForm> createState() => _ScorekeeperRegFormState();
}

class _ScorekeeperRegFormState extends State<ScorekeeperRegForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;

      List<String?> result = await _authService.registerScorekeeper(
        email: email,
        password: password,
      );

      String? userId = result[0];

      setState(() {
        _isLoading = false;
      });

      if (userId != null) {
        await saveAdminLoginState(true);
        await saveAdminEmail(email);
        await saveAdminType('scorekeeper');
        await saveAdminId(result[0]!);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful!',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerPage(),
          ),
        );

        // Optionally navigate to another page.
      } else {
        // If registration fails, show an error message.

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result[1] ?? 'Registration failed',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // For now, we'll just navigate to the PlayerPage.
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
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
                  onPressed: _handleRegister,
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
            ),
          );
  }
}
