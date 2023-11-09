import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final currentInstructor = FirebaseAuth.instance.currentUser;

class DrawerFile extends StatelessWidget {
  const DrawerFile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            const Text(
              'Instructor Login',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30,),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  '${currentInstructor!.email}',
                  style: const TextStyle(fontSize: 21, color: Colors.white),
                )),
            const SizedBox(height: 40,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: const Text('SignOut', style: TextStyle(
                fontSize: 18
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
