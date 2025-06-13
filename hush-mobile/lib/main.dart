import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/task_in_progress_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HushApp());
}

class HushApp extends StatelessWidget {
  const HushApp({super.key});

  Future<Widget> _getInitialScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      return const WelcomeScreen();
    }

    // Check for active tasks
    final tasksQuery = await FirebaseFirestore.instance
        .collection('tasks')
        .where('assignedTo', isEqualTo: user.uid)
        .where('status', isEqualTo: 'in_progress')
        .limit(1)
        .get();

    if (tasksQuery.docs.isNotEmpty) {
      final taskDoc = tasksQuery.docs.first;
      return TaskInProgressScreen(
        taskId: taskDoc.id,
        taskData: taskDoc.data(),
      );
    }

    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hush',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Error loading app'),
              ),
            );
          }

          return snapshot.data ?? const WelcomeScreen();
        },
      ),
    );
  }
}
