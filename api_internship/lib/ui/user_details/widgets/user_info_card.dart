import 'package:api_internship/models/user_response_model.dart';
import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final UserModel user;

  const UserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      color: Colors.green.shade100,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                user.profileImage,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const SizedBox(
                    width: 120,
                    height: 120,
                    child: Icon(Icons.error, color: Colors.red, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildUserInfoRow('Name', user.name, textTheme),
                  _buildUserInfoRow('User ID', user.userId.toString(), textTheme),
                  // --- UPDATE START ---
                  // Use null-aware operators to convert the nullable age to a blank string if it's null.
                  _buildUserInfoRow('Age', user.age?.toString() ?? '', textTheme),
                  // --- UPDATE END ---
                  _buildUserInfoRow('Profession', user.profession, textTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich(
        TextSpan(
          text: '$label: ',
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}