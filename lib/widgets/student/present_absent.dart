import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PresentAbsent extends StatelessWidget {
   const PresentAbsent({
    super.key,
    // required this.title,
    // required this.count,
    required this.isAbsent,
  });

  final String isAbsent;
  // final String title;
  // final int count;

  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Center(child: Text('Error Occurred'),);
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Wait! Loading'),);
          }
          if (!snapshots.hasData) {
            return const Center(child: Text('Data not found'),);
          }
          final attendance = snapshots.data!.docs;
          return ListView.builder(
              itemCount: attendance.length, itemBuilder: (context, index){
                final attend = attendance[index].data();
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          isAbsent == 'absent' ? 'Total Absents' : 'Total Presents',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(isAbsent == 'absent' ? attend['absent'].toString() : attend['present'].toString(),
                          style: const TextStyle(
                          fontSize: 80,
                          color: Colors.white,
                        ),),
                      ),
                    ],
                  ),
                );
          });
        });
  }
}
