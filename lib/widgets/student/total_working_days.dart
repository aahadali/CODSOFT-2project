import 'package:flutter/material.dart';

class TotalWorkingDays extends StatelessWidget {
  const TotalWorkingDays({
    super.key,
    required this.lastDate,
  });

  final int lastDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Working Days',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              lastDate.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ],
      ),
    );
  }
}
