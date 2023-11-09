import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:university_attendance_app/widgets/student/mark_attendance.dart';
import 'package:university_attendance_app/widgets/student/present_absent.dart';
import 'package:university_attendance_app/widgets/student/student_drawer.dart';
import 'package:university_attendance_app/widgets/student/total_working_days.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedDay = DateTime.now();
    DateTime _focusedDay = DateTime.now();
    CalendarFormat _calendarFormat = CalendarFormat.month;

    var now = DateTime.now();
    var beginningNextMonth = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);
    var lastDay = beginningNextMonth.subtract(const Duration(days: 1)).day;

    const containerShadow = [
      BoxShadow(
        color: Colors.black38,
        spreadRadius: 1,
        blurStyle: BlurStyle.outer,
        blurRadius: 3.2,
      )
    ];

    Widget leftDrawer = const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: StudentDrawer(),
      ),
    );
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text(
          'Attendance',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_outlined,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Attendance()));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: width * 0.85,
        child: leftDrawer,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                //height: 60,
                height: height * 0.04,
                decoration: const BoxDecoration(
                  boxShadow: containerShadow,
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
              ),
              // Positioned(
              //   bottom: 15,
              //   left: 15,
              //   right: 15,
              //   child: Container(
              //     height: 40,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(30)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.arrow_back_ios_new_outlined),
              //         ),
              //         const Text('January, 2020'),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.arrow_forward_ios_outlined),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            //height: 300,
            height: height * 0.43,
            decoration: BoxDecoration(
              //color: Colors.red,
              boxShadow: containerShadow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //height: 100,
            height: height * 0.1,
            decoration: BoxDecoration(
              boxShadow: containerShadow,
              //color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TotalWorkingDays(lastDate: lastDay),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                height: height * 0.2,
                width: width * 0.42,
                decoration: BoxDecoration(
                  boxShadow: containerShadow,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const PresentAbsent(isAbsent: 'absent'),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 15, right: 15),
                height: height * 0.2,
                width: width * 0.42,
                decoration: BoxDecoration(
                  boxShadow: containerShadow,
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const PresentAbsent(isAbsent: 'present'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
