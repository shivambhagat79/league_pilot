import 'package:flutter/material.dart';
import 'package:hunger_games/pages/admin/admin.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({super.key});

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // TODO: Login the user with the provided details.
      // For now, we'll just navigate to the PlayerPage.

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(),
        ),
      );
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'League Pilot',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Overcame",
                    letterSpacing: 3,
                  ),
                ),
                Text(
                  'Admin Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Overcame",
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(height: 50),
                Form(
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
                          Text(" Contact Super Admin",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "© League Pilot. All rights reserved.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
