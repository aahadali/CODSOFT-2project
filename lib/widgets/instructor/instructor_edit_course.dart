import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({super.key, required this.name});

  final String name;

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  final _formCourse = GlobalKey<FormState>();
  var courseName = '';

  void _pop() {
    Navigator.pop(context);
  }

  void _editCourse() async {
    final isValid = _formCourse.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formCourse.currentState!.save();

    await FirebaseFirestore.instance.collection('courses').doc(widget.name).update({
      'Courses Name' : courseName,
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
              'Edit Course',
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
              child: Form(
                key: _formCourse,
                child: TextFormField(
                  initialValue: widget.name,
                  maxLength: 20,
                  autocorrect: true,
                  decoration: const InputDecoration(
                      labelText: 'Course Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),),
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return;
                    }
                    return null;
                  },
                  onSaved: (value){
                    courseName = value!;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _editCourse,
                child: const Text('Edit Course'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
