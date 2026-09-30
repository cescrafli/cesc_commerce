import codecs, re

def append_keys(lang_code, new_keys):
    with codecs.open('lib/core/localization.dart', 'r', 'utf-8') as f:
        content = f.read()
    insert_str = ""
    for k, v in new_keys.items():
        insert_str += f"    '{k}': '{v}',\n"
    # Find the closing of this lang block
    marker = f"'{lang_code}': {{"
    idx = content.find(marker)
    if idx == -1:
        print(f"NOT FOUND: {lang_code}")
        return
    # Find the "  }," that closes this block (next occurrence after the opening)
    close_idx = content.find("\n  },", idx)
    content = content[:close_idx] + "\n" + insert_str + content[close_idx:]
    with codecs.open('lib/core/localization.dart', 'w', 'utf-8') as f:
        f.write(content)

def replace_in_file(path, replacements):
    import os
    if not os.path.exists(path): return
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    for k, v in replacements.items():
        content = content.replace(k, v)
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)

# Add search screen + notifications keys
append_keys('EN (US)', {
    'recent_searches': 'Recent Searches',
    'trending_now': 'Trending Now',
    'promos_deals': 'Promos & Deals',
    'account': 'Account',
    'today': 'TODAY',
    'earlier_this_week': 'EARLIER THIS WEEK',
    'mark_group_read': 'Mark group read',
    'track_order': 'Track Order',
    'shop_deals': 'Shop Deals',
    'no_notifications': 'No notifications',
    'help_support_title': 'Help & Support',
    'browse_categories': 'Browse categories',
    'how_can_we_help': 'How can we help you?',
    'explore_faq': 'Explore FAQ',
    'orders_shipping': 'Orders & Shipping',
    'payments_refunds': 'Payments & Refunds',
    'my_support_ticket': 'MY SUPPORT TICKET',
    'in_progress': 'In Progress',
})
append_keys('ID (ID)', {
    'recent_searches': 'Pencarian Terbaru',
    'trending_now': 'Trending Sekarang',
    'promos_deals': 'Promo & Penawaran',
    'account': 'Akun',
    'today': 'HARI INI',
    'earlier_this_week': 'MINGGU INI',
    'mark_group_read': 'Tandai sudah dibaca',
    'track_order': 'Lacak Pesanan',
    'shop_deals': 'Beli Promo',
    'no_notifications': 'Tidak ada notifikasi',
    'help_support_title': 'Bantuan & Dukungan',
    'browse_categories': 'Telusuri kategori',
    'how_can_we_help': 'Apa yang bisa kami bantu?',
    'explore_faq': 'Jelajahi FAQ',
    'orders_shipping': 'Pesanan & Pengiriman',
    'payments_refunds': 'Pembayaran & Pengembalian',
    'my_support_ticket': 'TIKET SAYA',
    'in_progress': 'Dalam Proses',
})
append_keys('ES (ES)', {
    'recent_searches': 'Busquedas recientes',
    'trending_now': 'Tendencias',
    'promos_deals': 'Promos y Ofertas',
    'account': 'Cuenta',
    'today': 'HOY',
    'earlier_this_week': 'ESTA SEMANA',
    'mark_group_read': 'Marcar como leido',
    'track_order': 'Rastrear pedido',
    'shop_deals': 'Ver Ofertas',
    'no_notifications': 'Sin notificaciones',
    'help_support_title': 'Ayuda y Soporte',
    'browse_categories': 'Explorar categorias',
    'how_can_we_help': 'Como podemos ayudarte?',
    'explore_faq': 'Explorar FAQ',
    'orders_shipping': 'Pedidos y Envios',
    'payments_refunds': 'Pagos y Devoluciones',
    'my_support_ticket': 'MI TICKET',
    'in_progress': 'En Progreso',
})
append_keys('ZH (CN)', {
    'recent_searches': '????',
    'trending_now': '????',
    'promos_deals': '?????',
    'account': '??',
    'today': '??',
    'earlier_this_week': '??????',
    'mark_group_read': '??????',
    'track_order': '????',
    'shop_deals': '????',
    'no_notifications': '????',
    'help_support_title': '?????',
    'browse_categories': '????',
    'how_can_we_help': '????????',
    'explore_faq': '????',
    'orders_shipping': '?????',
    'payments_refunds': '?????',
    'my_support_ticket': '????',
    'in_progress': '???',
})

# Replace in SearchScreen
replace_in_file('lib/screens/home/search_screen.dart', {
    "'Recent Searches'": "tr('recent_searches')",
    "'Clear All'": "tr('clear_all')",
    "'Trending Now'": "tr('trending_now')",
})

# Replace in NotificationsScreen
replace_in_file('lib/screens/profile/notifications_screen.dart', {
    "'Notifications'": "tr('notifications')",
    "'Orders'": "tr('orders')",
    "'Promos & Deals'": "tr('promos_deals')",
    "'Account'": "tr('account')",
    "'TODAY'": "tr('today')",
    "'EARLIER THIS WEEK'": "tr('earlier_this_week')",
    "'Mark group read'": "tr('mark_group_read')",
    "'Track Order'": "tr('track_order')",
    "'Shop Deals'": "tr('shop_deals')",
})

# Replace in NotificationScreen (singular)
replace_in_file('lib/screens/profile/notification_screen.dart', {
    "'Notifications'": "tr('notifications')",
    "'No notifications'": "tr('no_notifications')",
})

# Replace in HelpSupportScreen
replace_in_file('lib/screens/profile/help_support_screen.dart', {
    "'Help & Support'": "tr('help_support_title')",
    "'Browse categories'": "tr('browse_categories')",
    "'How can we help you?'": "tr('how_can_we_help')",
    "'Explore FAQ'": "tr('explore_faq')",
    "'Orders & Shipping'": "tr('orders_shipping')",
    "'Payments & Refunds'": "tr('payments_refunds')",
    "'MY SUPPORT TICKET'": "tr('my_support_ticket')",
    "'In Progress'": "tr('in_progress')",
})

print("All remaining screens translated")
