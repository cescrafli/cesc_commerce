class CustomerSupportChatScreen extends StatelessWidget {
  const CustomerSupportChatScreen({super.key});

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
                                  Text(' � Replies <1m', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                            child: const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0096C7)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                            child: const Icon(Icons.more_vert, size: 18, color: Colors.black87),
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
                            const Text(' � ', style: TextStyle(color: Colors.grey)),
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
                padding: const EdgeInsets.all(15),
                children: [
                  // Date
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
                      child: Text('TODAY, 10:24 AM', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Security Notice
                  Center(
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_user, color: Color(0xFF00B4D8), size: 16),
                          SizedBox(width: 8),
                          Expanded(child: Text('Cescrafli Priority Support. Conversations are encrypted & verified.', style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Agent Message 1
                  Row(
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
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                children: [
                                  TextSpan(text: 'Hi Cesc! ?? Thank you for reaching out to Cescrafli Priority Support. I see you\'re inquiring about your recent order '),
                                  TextSpan(text: '#ORD-9284', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '. How can I assist you today?'),
                                ]
                              )
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('10:24 AM', style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  // Quick Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 32), // indent
                        _buildQuickPill('??', 'Track my package', true),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Change address', true),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Invoice copy', false),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Exchange size', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // User Message
                  Row(
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
                            child: const Text('Hi Sarah! I wanted to check if the courier can leave the package at my front door if I\'m not home by 2 PM?', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Text('10:25 AM', style: TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.done_all, color: Color(0xFF00B4D8), size: 14),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Agent Response 2
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', width: 24, height: 24, fit: BoxFit.cover)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                  children: [
                                    TextSpan(text: 'Absolutely! I can update your delivery handover instructions directly in the system for courier '),
                                    TextSpan(text: 'Dave Miller', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: '.'),
                                  ]
                                )
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Rich Card
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                              child: Column(
                                children: [
                                  // Product
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100)),
                                    child: Row(
                                      children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://picsum.photos/seed/jacket/100/100', width: 45, height: 45, fit: BoxFit.cover)),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Denim Classic Jacket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
                                              const Text('Size L � Indigo Blue', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                              const SizedBox(height: 4),
                                              Row(children: [const Icon(Icons.two_wheeler, color: Colors.lightBlue, size: 12), const SizedBox(width: 4), Text('Arriving Today, ~2:30 PM', style: TextStyle(color: Colors.lightBlue.shade700, fontSize: 10, fontWeight: FontWeight.bold))])
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Instruction Status
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: const Color(0xFFE0F7FA).withOpacity(0.7), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.cyan.shade100)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(width: 24, height: 24, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14)),
                                            const SizedBox(width: 8),
                                            const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Front Door Drop-off', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                                Text('Instruction dispatched to Dave', style: TextStyle(color: Colors.black54, fontSize: 10)),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(6)), child: Text('Confirmed', style: TextStyle(color: Colors.green.shade800, fontSize: 10, fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 1),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Security PIN bypass authorized', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('#4920', style: TextStyle(color: Color(0xFF0096C7), fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Follow up text
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                  children: [
                                    TextSpan(text: 'I\'ve tagged order #ORD-9284 as '),
                                    TextSpan(text: '"Safe Contactless Front Porch Drop-off"', style: TextStyle(fontWeight: FontWeight.w600)),
                                    TextSpan(text: '. You\'ll receive a confirmation photo as soon as it\'s delivered!'),
                                  ]
                                )
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text('Was this resolution helpful?', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w500)),
                                const SizedBox(width: 8),
                                _buildFeedbackBtn('??'),
                                const SizedBox(width: 4),
                                _buildFeedbackBtn('??'),
                                const SizedBox(width: 8),
                                Text('10:26 AM', style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
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
                      child: const TextField(
                        decoration: InputDecoration(
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
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF0096C7)]),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
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
    return Container(
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
    );
  }

  Widget _buildFeedbackBtn(String emoji) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 2)]),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 10)),
    );
  }
}
