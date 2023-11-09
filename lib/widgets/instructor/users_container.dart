import 'package:flutter/material.dart';

class UsersContainer extends StatelessWidget {
  const UsersContainer({super.key, required this.name, required this.email});
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),),
              Text(email, style: const TextStyle(
                fontSize: 16
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
