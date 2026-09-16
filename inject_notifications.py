import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# 1. Inject globalNotifications
global_notif_code = '''final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> globalNotifications = ValueNotifier([
  {'id': 1, 'title': 'Flash Sale: Summer Collection', 'body': 'Get up to 50% off on all summer items today! Limited time offer.', 'isRead': false, 'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
  {'id': 2, 'title': 'New Arrival: Urban Fashion 2.0', 'body': 'Check out our latest streetwear arrivals exclusive for members.', 'isRead': false, 'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
  {'id': 3, 'title': 'Limited Edition Release', 'body': 'Winter Coat Premium Collection is out now. Buy 1 Get 1 Free while stocks last!', 'isRead': false, 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
]);'''
content = content.replace("final ValueNotifier<List<Map<String, dynamic>>> globalWishlist = ValueNotifier([]);", global_notif_code)

# 2. Update Bell Icon in HomeScreen
pattern_bell = r"GestureDetector\(\s*onTap: \(\) \{\s*ScaffoldMessenger\.of\(context\)\.showSnackBar\(const SnackBar\(content: Text\('You have no new notifications'\), duration: Duration\(seconds: 1\)\)\);\s*\},.*?\]\,\s*\),\s*\),"
replacement_bell = '''ValueListenableBuilder<List<Map<String, dynamic>>>(
                          valueListenable: globalNotifications,
                          builder: (context, notifs, _) {
                            final hasUnread = notifs.any((n) => n['isRead'] == false);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                              },
                              child: Stack(
                                children: [
                                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.notifications_none, size: 22, color: Colors.black87)),
                                  if (hasUnread) Positioned(top: 10, right: 10, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                                ],
                              ),
                            );
                          }
                        ),'''
content = re.sub(pattern_bell, replacement_bell, content, flags=re.DOTALL)

# 3. Add NotificationScreen & NewsDetailScreen at the end of the file
screens_code = '''
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: globalNotifications,
        builder: (context, notifs, _) {
          if (notifs.isEmpty) {
            return const Center(child: Text('No notifications', style: TextStyle(color: Colors.black54)));
          }
          return ListView.builder(
            itemCount: notifs.length,
            itemBuilder: (context, index) {
              final notif = notifs[index];
              final bool isRead = notif['isRead'];
              return GestureDetector(
                onTap: () {
                  // Mark as read
                  final current = List<Map<String, dynamic>>.from(globalNotifications.value);
                  current[index] = {...current[index], 'isRead': true};
                  globalNotifications.value = current;
                  
                  // Navigate
                  Navigator.push(context, MaterialPageRoute(builder: (_) => NewsDetailScreen(news: notif)));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isRead ? Colors.white : const Color(0xFFF0FBFF),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isRead ? Colors.grey.shade200 : const Color(0xFF18C5DF).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: NetworkImage(notif['image']), fit: BoxFit.cover)
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notif['title'], style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(notif['body'], style: TextStyle(color: Colors.grey.shade600, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      if (!isRead) Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF18C5DF), shape: BoxShape.circle))
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;
  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news['image'], width: double.infinity, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news['title'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Text(news['body'], style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
'''
content += screens_code

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Injected notification logic successfully")
