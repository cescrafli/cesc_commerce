import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CustomerSupportChatScreen extends StatefulWidget {
  const CustomerSupportChatScreen({super.key});

  @override
  State<CustomerSupportChatScreen> createState() => _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends State<CustomerSupportChatScreen> {
  final TextEditingController _messageCtrl = TextEditingController();
  final List<Map> _chatHistory = [
    {'isAgent': true, 'text': 'Hi! How can I help you today?', 'time': '10:30 AM'}
  ];
  final ScrollController _scrollCtrl = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  bool _agentTyping = false;

  @override
  void dispose() {
    _messageCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageCtrl.text.trim().isEmpty) return;
    
    setState(() {
      _chatHistory.add({
        'isAgent': false,
        'text': _messageCtrl.text,
        'time': TimeOfDay.now().format(context),
      });
      _messageCtrl.clear();
      _agentTyping = true;
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _chatHistory.add({
            'isAgent': true,
            'text': 'Thank you for your message. We will look into this right away.',
            'time': TimeOfDay.now().format(context),
          });
          _agentTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F9FD),

      body: SafeArea(

        child: Column(

          children: [

            // Top Nav

            Container(

              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),

              decoration: BoxDecoration(

                color: Colors.white,

                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),

                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))]

              ),

              child: Column(

                children: [

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Row(

                        children: [

                          GestureDetector(

                            onTap: () => Navigator.pop(context),

                            child: Container(

                              width: 36, height: 36,

                              decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black87),

                            ),

                          ),

                          const SizedBox(width: 12),

                          // Avatar

                          Stack(

                            children: [

                              Container(

                                width: 40, height: 40,

                                decoration: BoxDecoration(

                                  shape: BoxShape.circle,

                                  border: Border.all(color: const Color(0xFF00B4D8).withOpacity(0.3), width: 2),

                                ),

                                child: ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', fit: BoxFit.cover)),

                              ),

                              Positioned(

                                bottom: 0, right: 0,

                                child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2))),

                              )

                            ],

                          ),

                          const SizedBox(width: 12),

                          // Name & Status

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const Row(

                                children: [

                                  Text('Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),

                                  SizedBox(width: 4),

                                  Icon(Icons.check_circle, color: Colors.lightBlue, size: 14),

                                ],

                              ),

                              Row(

                                children: [

                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                                  const SizedBox(width: 4),

                                  const Text('Online', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),

                                  Text('  Replies <1m', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                ],

                              )

                            ],

                          )

                        ],

                      ),

                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                              child: const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0096C7)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                              child: const Icon(Icons.more_vert, size: 18, color: Colors.black87),
                            ),
                          )
                        ],
                      )

                    ],

                  ),

                  const SizedBox(height: 12),

                  // Context Chip

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                    decoration: BoxDecoration(

                      gradient: const LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFFE3F2FD)]),

                      borderRadius: BorderRadius.circular(12),

                      border: Border.all(color: Colors.cyan.shade100)

                    ),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Row(

                          children: [

                            Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF00B4D8).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF0096C7), size: 14)),

                            const SizedBox(width: 10),

                            const Text('Order #ORD-9284', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                            const Text('  ', style: TextStyle(color: Colors.grey)),

                            const Text('In Transit (Denim Jacket)', style: TextStyle(color: Color(0xFF00838F), fontSize: 12, fontWeight: FontWeight.w600)),

                          ],

                        ),

                        Container(

                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.cyan.shade200)),

                          child: const Row(

                            children: [

                              Text('View', style: TextStyle(color: Color(0xFF0096C7), fontSize: 11, fontWeight: FontWeight.bold)),

                              Icon(Icons.chevron_right, color: Color(0xFF0096C7), size: 14)

                            ],

                          ),

                        )

                      ],

                    ),

                  )

                ],

              ),

            ),

            

            // Chat Stream

            Expanded(

              child: ListView(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(15),
                children: [
                  ..._chatHistory.map((msg) => msg['isAgent'] ? _buildAgentBubble(msg) : _buildUserBubble(msg)).toList(),

                  if (_agentTyping)
                    const Padding(
                      padding: EdgeInsets.only(left: 32, bottom: 20),
                      child: Text('Agent is typing...', style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic)),
                    ),

                ],

              ),

            ),

            

            // Quick Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  _buildQuickPill('📦', 'Track my package', true),
                  const SizedBox(width: 8),
                  _buildQuickPill('📍', 'Change address', true),
                  const SizedBox(width: 8),
                  _buildQuickPill('📄', 'Invoice copy', false),
                  const SizedBox(width: 8),
                  _buildQuickPill('👕', 'Exchange size', false),
                ],
              ),
            ),
            
            // Input Bar

            Container(

              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

              decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))),

              child: Row(

                children: [

                  Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle), child: const Icon(Icons.attach_file, color: Colors.black54, size: 20)),

                  const SizedBox(width: 8),

                  Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle), child: const Icon(Icons.camera_alt_outlined, color: Colors.black54, size: 20)),

                  const SizedBox(width: 8),

                  Expanded(

                    child: Container(

                      height: 40,

                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),

                      child: TextField(
                        controller: _messageCtrl,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: const InputDecoration(

                          hintText: 'Type your message...',

                          hintStyle: TextStyle(color: Colors.black38, fontSize: 13),

                          border: InputBorder.none,

                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),

                          suffixIcon: Icon(Icons.sentiment_satisfied_alt, color: Colors.black38, size: 20),

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(

                      width: 40, height: 40,

                      decoration: BoxDecoration(

                        gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF0096C7)]),

                        shape: BoxShape.circle,

                        boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]

                      ),

                      child: const Icon(Icons.send, color: Colors.white, size: 18),

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



  Widget _buildQuickPill(String emoji, String text, bool isCyan) {
    return GestureDetector(
      onTap: () {
        _messageCtrl.text = text;
        _sendMessage();
      },
      child: Container(

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: isCyan ? const Color(0xFF00B4D8).withOpacity(0.5) : Colors.grey.shade300),

        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 2)]

      ),

      child: Row(

        children: [

          Text(emoji, style: const TextStyle(fontSize: 12)),

          const SizedBox(width: 6),

          Text(text, style: TextStyle(color: isCyan ? const Color(0xFF0077B6) : Colors.black87, fontSize: 12, fontWeight: FontWeight.w600)),

        ],
      ),
    ));
  }





  Widget _buildAgentBubble(Map msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', width: 24, height: 24, fit: BoxFit.cover)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                child: Text(msg['text'], style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto')),
              ),
              const SizedBox(height: 4),
              Text(msg['time'], style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUserBubble(Map msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF0096C7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16), bottomRight: Radius.circular(4)),
                  boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                ),
                child: Text(msg['text'], style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(msg['time'], style: const TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, color: Color(0xFF00B4D8), size: 14),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

}
