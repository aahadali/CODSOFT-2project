import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:university_attendance_app/widgets/instructor/instructor_edit_course.dart';

class ShowCourses extends StatefulWidget {
  const ShowCourses({super.key});

  @override
  State<ShowCourses> createState() => _ShowCoursesState();
}

class _ShowCoursesState extends State<ShowCourses> {
  void _deleteCourse(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you Sure?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This Course will be deleted.'),
            const SizedBox(
              height: 7,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('courses')
                    .doc(name)
                    .delete();
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  void _editCourse(String name) {
    showModalBottomSheet(
      context: context,
      builder: (context) => EditCourse(name: name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No Course Found'));
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Wait! Loading '));
          }
          if (snapshots.hasError) {
            return const Center(child: Text('Error Found'));
          }

          final courses = snapshots.data!.docs;
          return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index].data();
                return ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editCourse(course['Courses Name']);
                    },
                  ),
                  title: Text(course['Courses Name']),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () {
                        _deleteCourse(
                          course['Courses Name'],
                        );
                      }),
                );
              });
        });
  }
}
