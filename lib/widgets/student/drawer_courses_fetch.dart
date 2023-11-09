import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoursesFetch extends StatelessWidget {
  const CoursesFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('courses').snapshots(),
            builder: (context, snapshots) {
              if (snapshots.hasError) {
                return const Center(
                  child: Text('Error Occured!'),
                );
              }
              if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                return const Center(
                  child: Text('Data not found!'),
                );
              }
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text('Waiting for Data'),
                );
              }
              final usersInfo = snapshots.data!.docs;
              return ListView.builder(
                  itemCount: usersInfo.length,
                  itemBuilder: (context, index) {
                    final userInfo = usersInfo[index].data();
                    return Column(
                      children: [
                        const Text(
                          'Courses',
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Card(
                          color: Colors.purple,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              userInfo['Courses Name'],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
