with open('lib/screens/profile/customer_support_chat_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_input = '''TextField(

                          decoration: InputDecoration(

                            hintText: 'Type your message...',

                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),

                            border: InputBorder.none,

                          ),

                        )'''

new_input = '''TextField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        )'''

content = content.replace(old_input, new_input)

old_send = '''Container(

                      padding: const EdgeInsets.all(12),

                      decoration: const BoxDecoration(

                        color: Color(0xFF00BCD4),

                        shape: BoxShape.circle,

                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],

                      ),

                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),

                    )'''

new_send = '''GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent!')));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00BCD4),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                      ),
                    )'''

content = content.replace(old_send, new_send)

with open('lib/screens/profile/customer_support_chat_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed chat')
