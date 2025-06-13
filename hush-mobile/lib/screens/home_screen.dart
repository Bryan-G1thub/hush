import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_screen.dart';
import 'task_in_progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Add a flag to track if we're in the process of accepting a task
  bool _isAcceptingTask = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error loading user data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;
              final userName = userData['name'] as String? ?? 'User';

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _signOut(context),
                          icon: const Icon(Icons.logout, color: Colors.white70),
                          label: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Your Tasks',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('tasks')
                                  .where('status', isEqualTo: 'LIVE')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                print('StreamBuilder rebuilding...');
                                
                                // If we're in the middle of accepting a task, show loading
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      'Something went wrong',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No tasks found',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final doc = snapshot.data!.docs[index];
                                    final data = doc.data() as Map<String, dynamic>;
                                    
                                    return Card(
                                      color: Colors.white.withOpacity(0.1),
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: ListTile(
                                        title: Text(
                                          data['test'] ?? 'No Title',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Status: ${data['status'] ?? 'Unknown'}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        trailing: ElevatedButton(
                                          onPressed: () => _acceptTask(context, doc.id, data),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Accept Task'),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully signed out'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error signing out'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _acceptTask(BuildContext context, String taskId, Map<String, dynamic> taskData) async {
    print('=== Starting _acceptTask ===');
    print('Task ID: $taskId');

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Show loading feedback before navigation
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task accepted, redirecting...'),
            duration: Duration(seconds: 1),
          ),
        );
      }

      // Navigate to TaskInProgressScreen FIRST
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => TaskInProgressScreen(
            taskId: taskId,
            taskData: taskData, // using the original data, or you can refetch after
          ),
        ),
      );

      print('1. Navigation triggered. Delaying update...');

      // Delay to allow navigation transition to settle
      await Future.delayed(const Duration(milliseconds: 300));

      // Now update Firestore in the background
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
        'status': 'IN_PROGRESS',
        'assignedTo': user.uid,
        'assignedAt': FieldValue.serverTimestamp(),
      });

      print('2. Firestore update complete');
    } catch (e) {
      print('ERROR in _acceptTask: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error accepting task'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    print('=== End of _acceptTask ===');
  }
} 