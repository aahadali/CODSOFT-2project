import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/widgets/instructor/users_container.dart';

class ShowStudents extends StatelessWidget {
  const ShowStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No User Found'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Wait! Loading'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error Found'),
          );
        }
        final users = snapshot.data!.docs;
        return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data();
              return UsersContainer(
                name: user['user_name'],
                email: user['email_address'],
              );
            });
      },
    );
  }
}
