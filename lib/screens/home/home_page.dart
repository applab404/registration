import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration/models/user.dart';
import 'package:registration/screens/login/login_page.dart';
import 'package:registration/services/auth_service.dart';
import 'package:registration/utils/date_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<UserModel?> _getUserModel() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.exists ? UserModel.fromMap(uid, doc.data()!) : null;
  }

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: _getUserModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(child: Text('User not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${user.name}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                _buildInfo('Email', user.email),
                _buildInfo('Gender', user.gender),
                _buildInfo('DOB', DateUtilsHelper.format(user.dob)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$label: $value'),
    );
  }
}
