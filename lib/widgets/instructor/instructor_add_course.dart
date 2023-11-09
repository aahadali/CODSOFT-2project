import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _courseNameController = TextEditingController();

  void _pop() {
    Navigator.pop(context);
  }

  void _addCourse() async {
    final addedCourse = _courseNameController.text.trim();

    if (addedCourse.isEmpty) {
      return;
    }
    await FirebaseFirestore.instance
        .collection('courses')
        .doc(addedCourse)
        .set({
      'Courses Name': addedCourse,
    });
    _pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xff9600FF),
              Color(0xffAEBAF8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Course',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Card(
              shadowColor: Colors.black45,
              child: TextField(
                maxLength: 20,
                autocorrect: true,
                controller: _courseNameController,
                decoration: const InputDecoration(
                    labelText: 'Course Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    )),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _addCourse,
                child: const Text('Add Course'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
