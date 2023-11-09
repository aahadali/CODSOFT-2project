import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/widgets/student/drawer_courses_fetch.dart';


final currentUser = FirebaseAuth.instance.currentUser;
class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    void onClick(){
      showModalBottomSheet(context: context, builder: (context) => const CoursesFetch());
    }


    return Column(
      children: [
        const Text(
          'Profile',
          style:
          TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                '${currentUser!.displayName}',
                style: const TextStyle(
                  fontSize: 27,
                ),
              ),
              Text(
                '${currentUser!.email}',
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40,),
        OutlinedButton(onPressed: onClick, child: const Text('Courses'),),
        const SizedBox(height: 40,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
