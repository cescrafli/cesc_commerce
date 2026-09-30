
import 'package:flutter/foundation.dart';
class UserService {
  // Mock current user profile data

  static final ValueNotifier<Map<String, dynamic>> mockProfile = ValueNotifier({
    'name': 'Cesc Fabregas',
    'email': 'cesc.fabregas@clubmail.com',
    'phone': '(555) 382-9014',
    'avatar': 'https://i.pravatar.cc/150?img=11',
    'dob': 'May 4, 1987',
    'gender': 'Male'
  });

  Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return mockProfile.value;
  }

  Future<void> updateProfile(Map<String, dynamic> newData) async {
    await Future.delayed(const Duration(milliseconds: 800));
    mockProfile.value = {...mockProfile.value, ...newData};
  }

  Future<void> clearProfile() async {
    mockProfile.value = {};
  }
}
