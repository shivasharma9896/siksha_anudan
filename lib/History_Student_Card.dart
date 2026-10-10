import 'package:flutter/material.dart';

class History_Profile_Card extends StatelessWidget {
  const History_Profile_Card({Key? key, required this.transdetail})
      : super(key: key);

  final Map<String, dynamic> transdetail;

  @override
  Widget build(BuildContext context) {
    final studentName = transdetail['StudentName']?.toString() ?? 'Student';
    final amount = transdetail['DonatedAmount']?.toString() ?? '0';
    final date = transdetail['date']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.school),
        ),
        title: Text(studentName),
        subtitle:
            Text(date.isEmpty ? 'Donation: ₹$amount' : '$date · ₹$amount'),
      ),
    );
  }
}
