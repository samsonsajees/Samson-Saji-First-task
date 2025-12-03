import 'package:api_internship/provider/user_provider.dart';
import 'package:api_internship/ui/user_details/widgets/message_display.dart';
import 'package:api_internship/ui/user_details/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController _userIdController;

  @override
  void initState() {
    super.initState();
    _userIdController = TextEditingController();
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _fetchUser() {
    final String userId = _userIdController.text.trim();
    if (userId.isNotEmpty) {
      context.read<UserProvider>().fetchUser(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch User Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchUser,
              child: const Text('Fetch User'),
            ),

            // --- UPDATE START ---
            // Dedicated consumer to display the error message right below the button.
            Consumer<UserProvider>(
              builder: (BuildContext context, UserProvider provider, Widget? child) {
                // Only show the error if it exists and we are not in a loading state.
                if (provider.errorMessage != null && !provider.isLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MessageDisplay(
                      message: provider.errorMessage!,
                      isError: true,
                    ),
                  );
                }
                // Otherwise, show nothing in this space.
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 24.0),

            // This consumer handles the main content display (loading, success, initial).
            Consumer<UserProvider>(
              builder: (BuildContext context, UserProvider provider, Widget? child) {
                if (provider.isLoading) {
                  return const CircularProgressIndicator();
                }

                // The user card is only shown on success. The error case is handled above.
                if (provider.user != null) {
                  return UserInfoCard(user: provider.user!);
                }

                // Show the initial message only if there is no error.
                if (provider.errorMessage == null) {
                  return const MessageDisplay(
                    message: 'Enter a user id and click button to get the user details',
                  );
                }
                
                return const SizedBox.shrink(); // Return empty space if an error is shown above.
              },
            ),
            // --- UPDATE END ---
          ],
        ),
      ),
    );
  }
}