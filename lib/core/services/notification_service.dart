import 'package:cesc_commerce/core/globals.dart';

class NotificationService {
  Future<List<Map<String, dynamic>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return globalNotifications.value;
  }

  Future<void> markAsRead(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final current = List<Map<String, dynamic>>.from(globalNotifications.value);
    final index = current.indexWhere((n) => n['id']?.toString() == id);
    if (index != -1) {
      current[index] = {...current[index], 'isRead': true};
      globalNotifications.value = current;
    }
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 500));
    globalNotifications.value = globalNotifications.value.map((n) => {...n, 'isRead': true}).toList();
  }
}
