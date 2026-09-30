import re

with open('lib/screens/misc/payment_methods_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Make tiles selectable/tappable
content = content.replace('class PaymentMethodsScreen extends StatelessWidget {', '''class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _selectedMethod = 'Mastercard';
''')
content = content.replace('const PaymentMethodsScreen({super.key});', '')

# Modify _buildMethodTile signature
content = content.replace('''  Widget _buildMethodTile(BuildContext context, String icon, String title, String subtitle, {Widget? trailingWidget, bool isPrimary = false}) {''', '''  Widget _buildMethodTile(BuildContext context, String icon, String title, String subtitle, {Widget? trailingWidget, bool isPrimary = false, String methodId = ''}) {''')

# Make it tappable and show selected state
old_tile_body = '''    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200, width: 1.5)),
      child: Row('''
new_tile_body = '''    bool isSelected = _selectedMethod == methodId;
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = methodId),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200, width: isSelected ? 2 : 1.5)),
        child: Row('''
content = content.replace(old_tile_body, new_tile_body)

# Update calls to _buildMethodTile
content = content.replace('''              _buildMethodTile(context, 'assets/icons/mastercard.png', 'Mastercard', '****  ****  ****  8831',
                  isPrimary: true,
                  trailingWidget: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: Text('Set Default', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)))),''', '''              _buildMethodTile(context, 'assets/icons/mastercard.png', 'Mastercard', '****  ****  ****  8831',
                  isPrimary: true,
                  methodId: 'Mastercard',
                  trailingWidget: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: Text('Set Default', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)))),''')

content = content.replace('''              _buildMethodTile(context, 'assets/icons/visa.png', 'Visa', '****  ****  ****  4242', trailingWidget: const Icon(Icons.more_vert, color: Colors.grey)),''', '''              _buildMethodTile(context, 'assets/icons/visa.png', 'Visa', '****  ****  ****  4242', methodId: 'Visa', trailingWidget: const Icon(Icons.more_vert, color: Colors.grey)),''')

content = content.replace('''              _buildMethodTile(context, 'assets/icons/apple.png', 'Apple Pay', 'Ready \u2192'),''', '''              _buildMethodTile(context, 'assets/icons/apple.png', 'Apple Pay', 'Ready \u2192', methodId: 'ApplePay'),''')

content = content.replace('''              _buildMethodTile(context, 'assets/icons/paypal.png', 'PayPal', 'Connected \u2192'),''', '''              _buildMethodTile(context, 'assets/icons/paypal.png', 'PayPal', 'Connected \u2192', methodId: 'PayPal'),''')

# Make + button work
content = content.replace('''              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              )''', '''              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add New Card coming soon'))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              )''')

with open('lib/screens/misc/payment_methods_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed payment_methods_screen.dart')
