import re

# NOTIFICATIONS SCREEN
with open('lib/screens/profile/notifications_screen.dart', 'r', encoding='utf-8') as f:
    notif = f.read()

# Make "Mark all read" work
notif = notif.replace('class NotificationsScreen extends StatelessWidget {', '''class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  bool _allRead = false;
''')
notif = notif.replace('const NotificationsScreen({super.key});', '')

notif = notif.replace('''                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                          child: Icon(Icons.check, size: 16, color: Theme.of(context).primaryColor),
                        )''', '''                        GestureDetector(
                          onTap: () => setState(() => _allRead = true),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Theme.of(context).primaryColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                            child: Icon(Icons.check, size: 16, color: Theme.of(context).primaryColor),
                          ),
                        )''')

# Filter logic
old_chips = '''                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildFilterChip('All (8)', true),
                          _buildFilterChip('Orders', false),
                          _buildFilterChip('Promos', false),
                          _buildFilterChip('Account', false),
                        ]
                      )
                    ),'''
new_chips = '''                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          GestureDetector(onTap: () => setState(() => _selectedFilter = 'All'), child: _buildFilterChip('All', _selectedFilter == 'All')),
                          GestureDetector(onTap: () => setState(() => _selectedFilter = 'Orders'), child: _buildFilterChip('Orders', _selectedFilter == 'Orders')),
                          GestureDetector(onTap: () => setState(() => _selectedFilter = 'Promos'), child: _buildFilterChip('Promos', _selectedFilter == 'Promos')),
                          GestureDetector(onTap: () => setState(() => _selectedFilter = 'Account'), child: _buildFilterChip('Account', _selectedFilter == 'Account')),
                        ]
                      )
                    ),'''
notif = notif.replace(old_chips, new_chips)

# Update unread dots based on _allRead
notif = notif.replace('bool isUnread,', 'bool isUnreadParam,')
notif = notif.replace('bool isUnread = isUnreadParam;', 'bool isUnread = _allRead ? false : isUnreadParam;')

# Make actions tappable
notif = notif.replace('''                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
                                    child: Text(actionText, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  )''', '''                                  GestureDetector(
                                    onTap: () {
                                      if (actionText == 'Track Order') Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingLiveScreen()));
                                      else if (actionText == 'Shop Deals') Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen()));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
                                      child: Text(actionText, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),
                                  )''')

with open('lib/screens/profile/notifications_screen.dart', 'w', encoding='utf-8') as f:
    f.write(notif)


# HELP SUPPORT SCREEN
with open('lib/screens/profile/help_support_screen.dart', 'r', encoding='utf-8') as f:
    help_screen = f.read()

help_screen = help_screen.replace('class HelpSupportScreen extends StatelessWidget {', '''class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final Map<int, bool> _faqExpanded = {};
''')
help_screen = help_screen.replace('const HelpSupportScreen({super.key});', '')

# FAQ accordion
old_faq = '''_buildFaqItem('How do I track my order?', 'You can track your order by going to Profile > My Orders > Track Order. A live map will show your courier\\'s current location.'),
                      _buildFaqItem('What is the return policy?', 'We accept returns within 30 days of purchase. Items must be unworn and in their original packaging.'),'''
new_faq = '''_buildFaqItem(0, 'How do I track my order?', 'You can track your order by going to Profile > My Orders > Track Order. A live map will show your courier\\'s current location.'),
                      _buildFaqItem(1, 'What is the return policy?', 'We accept returns within 30 days of purchase. Items must be unworn and in their original packaging.'),'''
help_screen = help_screen.replace(old_faq, new_faq)

old_faq_method = '''  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
              const Icon(Icons.keyboard_arrow_up, color: Colors.grey, size: 20),
            ]
          ),
          const SizedBox(height: 10),
          Text(answer, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5)),
        ]
      )
    );
  }'''
new_faq_method = '''  Widget _buildFaqItem(int index, String question, String answer) {
    bool isExpanded = _faqExpanded[index] ?? false;
    return GestureDetector(
      onTap: () => setState(() => _faqExpanded[index] = !isExpanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
              ]
            ),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              Text(answer, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5)),
            ]
          ]
        )
      )
    );
  }'''
help_screen = help_screen.replace(old_faq_method, new_faq_method)

# Contact buttons
old_contact = '''_buildContactOption(Icons.chat_outlined, 'Live Chat', 'Wait ~2 min'),
                      const SizedBox(width: 15),
                      _buildContactOption(Icons.phone_outlined, 'Call Center', 'Wait ~5 min'),
                      const SizedBox(width: 15),
                      _buildContactOption(Icons.email_outlined, 'Email Us', 'Wait ~2 hrs'),'''
new_contact = '''GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen())), child: _buildContactOption(Icons.chat_outlined, 'Live Chat', 'Wait ~2 min')),
                      const SizedBox(width: 15),
                      GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Calling toll-free: 1-800-CESC-SHOP'))), child: _buildContactOption(Icons.phone_outlined, 'Call Center', 'Wait ~5 min')),
                      const SizedBox(width: 15),
                      GestureDetector(onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email: support@cesccommerce.com'))), child: _buildContactOption(Icons.email_outlined, 'Email Us', 'Wait ~2 hrs')),'''
help_screen = help_screen.replace(old_contact, new_contact)

with open('lib/screens/profile/help_support_screen.dart', 'w', encoding='utf-8') as f:
    f.write(help_screen)

print('Fixed batch4.1')
