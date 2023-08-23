import 'package:flutter/material.dart';
import 'package:user_list/domain/user.dart'; // Import the correct path for your User class

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(user.picture), // Display the user's picture
            SizedBox(height: 16.0),
            Text('Name: ${user.name}'),
            Text('Location: ${user.location}'),
            Text('Email: ${user.email}'),
            Text('Date of Birth: ${user.dob}'),
            Text('Phone: ${user.phone}'),
            Text('Cell: ${user.cell}'),
          ],
        ),
      ),
    );
  }
}
