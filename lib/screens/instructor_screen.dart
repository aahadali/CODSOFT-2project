import 'package:flutter/material.dart';
import 'package:university_attendance_app/widgets/instructor/drawer_file.dart';
import 'package:university_attendance_app/widgets/instructor/instructor_add_course.dart';
import 'package:university_attendance_app/widgets/instructor/showCourses.dart';
import 'package:university_attendance_app/widgets/instructor/showStudents.dart';

class InstructorScreen extends StatefulWidget {
  const InstructorScreen({super.key});

  @override
  State<InstructorScreen> createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addCourse() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddCourse(),
    );
  }

  final List _screens = [
    const ShowCourses(),
    const ShowStudents(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _addCourse,
            icon: const Icon(Icons.add_circle),
          ),
        ],
      ),
      drawer: const Drawer(
        child: DrawerFile(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Students'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTapItem,
      ),
      body: _screens[_selectedIndex],
    );
  }
}
