import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // Toggle between login and signup
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple.shade900,
                  Colors.black,
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            // Title
                            Text(
                              isLogin ? 'Welcome Back' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isLogin 
                                ? 'Sign in to continue your mystery shopping journey'
                                : 'Join our community of mystery shoppers',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            // Name field (only for signup)
                            if (!isLogin) ...[
                              TextFormField(
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  labelStyle: const TextStyle(color: Colors.white70),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.white24),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: Colors.deepPurple),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.1),
                                ),
                                validator: (value) {
                                  if (!isLogin && (value == null || value.isEmpty)) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                            ],
                            // Email field
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.white70),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.deepPurple),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            // Password field
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.deepPurple),
                                ),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (!isLogin && value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            // Submit button
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // TODO: Implement auth logic
                                  print('Form is valid');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                isLogin ? 'Sign In' : 'Create Account',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Toggle between login and signup
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(
                                isLogin 
                                  ? 'Don\'t have an account? Sign Up'
                                  : 'Already have an account? Sign In',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 