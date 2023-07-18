import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('scores')
          .orderBy('score', descending: true)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final scores = snapshot.data!.docs.map((doc) {
            final data = doc.data();
            return data != null ? data as Map<String, dynamic> : {};
          }).toList();

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (ctx, index) => ListTile(
              title: Text('Score: ${scores[index]['score'] ?? 'N/A'}'),
              subtitle: Text(
                  'Timestamp: ${(scores[index]['timestamp'] as Timestamp?)?.toDate() ?? 'N/A'}'),
            ),
          );
        }
      },
    );
  }
}
