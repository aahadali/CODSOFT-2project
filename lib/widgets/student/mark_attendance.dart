import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final currentUser = FirebaseAuth.instance.currentUser;
final fireStore = FirebaseFirestore.instance;
class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  var _isPresent = false;
  var _isAbsent = false;
  var presentCount = 0;
  var absentCount = 0;

  int get absent{
    var count = 0 ;
    if(_isPresent == false || _isAbsent == true){
      final count1 = absentCount = absentCount + 1;
      count = count1;
    }
    return count;
  }
  int get present{
    var count = 0 ;
    if(_isAbsent == false || _isPresent == true){
      final count1 = presentCount = presentCount + 1;
      count = count1;
    }
    return count;
  }

  void _willPop(){
    Navigator.pop(context);
  }

  void _markAttendance() async {
    if(_isPresent == false && _isAbsent == false){
      return;
    }
    await fireStore.collection('attendance').doc(currentUser?.uid).set({
      'absent' : absent,
      'present' : present,
      'date' : Timestamp.now(),
    });
    _willPop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Attendance',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        child: Column(
          children: [
            SwitchListTile(
                activeColor: Colors.purple,
                title: const Text(
                  'Present',
                  style: TextStyle(fontSize: 19),
                ),
                value: _isPresent,
                onChanged: (value) {
                  setState(() {
                    _isPresent = value;
                    _isAbsent = false;
                  });
                }),
            SwitchListTile(
                activeColor: Colors.purple,
                title: const Text(
                  'Absent',
                  style: TextStyle(fontSize: 19),
                ),
                value: _isAbsent,
                onChanged: (value) {
                  setState(() {
                    _isAbsent = value;
                    _isPresent = false;
                  });
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  ElevatedButton(onPressed: _markAttendance, child: const Text('Mark')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
