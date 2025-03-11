import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/pages/player/player.dart';
import 'package:hunger_games/services/auth.dart';

class PlayerRegForm extends StatefulWidget {
  final Function toggleAuth;
  const PlayerRegForm({super.key, required this.toggleAuth});

  @override
  State<PlayerRegForm> createState() => _PlayerRegFormState();
}

class _PlayerRegFormState extends State<PlayerRegForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _tournaments = ["Aarohan'25", "Inter IIT'25"];
  final List<String> _contingents = [
    "IIT Ropar",
    "IIT Kanpur",
    "IIT Delhi",
    "IIT Mandi"
  ];

  String? _selectedTournament;
  String? _selectedContingent;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String name = _nameController.text;
      String phone = _phoneController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      String? userId = await _authService.registerPlayer(
        name: name,
        email: email,
        password: password,
        phone: phone,
        tournamentContingent: _selectedContingent!,
        tournament: _selectedTournament!,
      );

      setState(() {
        _isLoading = false;
      });

      if (userId != null) {
        // If registration is successful, show a success message.
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
          const SnackBar(
            content: Text(
              'Registration failed. Please try again.',
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
    // Dispose controllers when the widget is removed from the widget tree.
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: 'Name',
                    hintText: 'Enter your Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: 'Phone Number',
                    hintText: 'Enter your Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    // Validate phone number format (10 digits in this example).
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Tournament',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  value: _selectedTournament,
                  items: _tournaments.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTournament = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a tournamnet' : null,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Contingent',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  value: _selectedContingent,
                  items: _contingents.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: _selectedTournament == null
                      ? null
                      : (newValue) {
                          setState(() {
                            _selectedContingent = newValue;
                          });
                        },
                  validator: (value) =>
                      value == null ? 'Please select your contingent' : null,
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
