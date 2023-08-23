import 'package:flutter/material.dart';
import 'package:user_list/data/UserRepository';
import 'package:user_list/domain/user.dart';
import 'package:user_list/presentation/UserDetailsPage.dart';
import 'package:user_list/domain/getUsers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User List',
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('User List'),
            bottom: const TabBar(
              tabs: [Tab(text: "Male"), Tab(text: "Female")],
            ),
          ),
          body: TabBarView(
            children: [
              // Display different screens based on the selected tab index
              _buildTabScreen(0),
              _buildTabScreen(1),
            ],
          ),
        ));
  }

  Widget _buildTabScreen(int tabIndex) {
    late Future<List<dynamic>> userFetchFunction;
    final GenderFilteredUserUseCase genderFilteredUserUseCase =
        GenderFilteredUserUseCase(userRepository: UserRepository());
    if (tabIndex == 0) {
      userFetchFunction = genderFilteredUserUseCase.getMaleUsers(10);
    } else if (tabIndex == 1) {
      userFetchFunction = genderFilteredUserUseCase.getFemaleUsers(10);
    }

    return FutureBuilder<List<dynamic>>(
      future: userFetchFunction,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading users'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users available'));
        } else {
          final List<dynamic> users = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final User user = users[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(user: user),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.network(user.picture), // Display the user's picture
                      Text(user.name), // Display the user's name
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
