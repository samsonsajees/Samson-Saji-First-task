import 'package:api_internship/models/user_response_model.dart';
import 'package:api_internship/network/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUser(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    try {
      final UserResponseModel response = await _userService.fetchUserData(userId);
      if (response.success && response.user != null) {
        _user = response.user;
      } else {
        _errorMessage = response.error ?? 'No user found';
      }
    } catch (e) {
      // --- UPDATE START ---
      // Added a print statement for debugging purposes as requested.
      // This will show up in your debug console (e.g., in VS Code or Android Studio).
      debugPrint('Something went wrong: $e');
      // --- UPDATE END ---
      _errorMessage = 'Something went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearProvider() {
    _user = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}