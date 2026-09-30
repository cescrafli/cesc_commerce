import codecs, re

with codecs.open('lib/core/localization.dart', 'r', 'utf-8') as f:
    content = f.read()

# Add missing keys to EN
en_add = """    'add_all_to_cart': 'Add All to Cart',
    'my_cart': 'My Cart',
    'total': 'Total:',
    'start_shopping': 'Start Shopping',
    'your_cart_is_empty': 'Your Cart is Empty',
    'hot': 'Hot',
    'favorites': 'Favorites',
    'saved_items': 'saved items',
    'all_items_in_stock': 'All items in stock',
    'move_all_to_cart': 'Move All to Cart',
    'no_items_to_move': 'No items to move',
    'moved_all_to_cart': 'Moved all to Cart!',
    'account_profile': 'Account & Profile',
    'orders': 'Orders',
    'vouchers': 'Vouchers',
    'personal_info': 'Personal Info',
    'personal_info_desc': 'Name, Email, Phone number',
    'my_orders_desc': 'Order history & tracking',
    'promos_alerts': 'Promos & status alerts',
    'payment_methods': 'Payment Methods',
    'payment_methods_desc': 'Visa ending in 4242',
    'faq_desc': 'FAQ & Customer Service',
    'sign_out_desc': 'Sign out of your account',"""
content = content.replace("'add_all_to_cart': 'Add All to Cart',", en_add)

# Add missing keys to ID
id_add = """    'add_all_to_cart': 'Masukkan Semua',
    'my_cart': 'Keranjang Saya',
    'total': 'Total:',
    'start_shopping': 'Mulai Belanja',
    'your_cart_is_empty': 'Keranjang Anda Kosong',
    'hot': 'Populer',
    'favorites': 'Favorit',
    'saved_items': 'barang disimpan',
    'all_items_in_stock': 'Semua barang tersedia',
    'move_all_to_cart': 'Pindah Semua ke Keranjang',
    'no_items_to_move': 'Tidak ada barang',
    'moved_all_to_cart': 'Berhasil dipindah!',
    'account_profile': 'Akun & Profil',
    'orders': 'Pesanan',
    'vouchers': 'Voucher',
    'personal_info': 'Info Pribadi',
    'personal_info_desc': 'Nama, Email, No HP',
    'my_orders_desc': 'Riwayat pesanan',
    'promos_alerts': 'Promo & notifikasi',
    'payment_methods': 'Metode Pembayaran',
    'payment_methods_desc': 'Visa berakhiran 4242',
    'faq_desc': 'FAQ & Layanan Pelanggan',
    'sign_out_desc': 'Keluar dari akun',"""
content = content.replace("'add_all_to_cart': 'Masukkan Semua',", id_add)

# Add missing keys to ES
es_add = """    'add_all_to_cart': 'Agregar Todo',
    'my_cart': 'Mi Carrito',
    'total': 'Total:',
    'start_shopping': 'Empezar a Comprar',
    'your_cart_is_empty': 'Tu carrito está vacío',
    'hot': 'Popular',
    'favorites': 'Favoritos',
    'saved_items': 'artículos',
    'all_items_in_stock': 'Todo en stock',
    'move_all_to_cart': 'Mover al Carrito',
    'no_items_to_move': 'Nada que mover',
    'moved_all_to_cart': '¡Movido al Carrito!',
    'account_profile': 'Cuenta y Perfil',
    'orders': 'Pedidos',
    'vouchers': 'Cupones',
    'personal_info': 'Info Personal',
    'personal_info_desc': 'Nombre, Correo, Tel',
    'my_orders_desc': 'Historial de pedidos',
    'promos_alerts': 'Promos y alertas',
    'payment_methods': 'Métodos de Pago',
    'payment_methods_desc': 'Visa terminada en 4242',
    'faq_desc': 'Ayuda y Soporte',
    'sign_out_desc': 'Cerrar sesión',"""
content = content.replace("'add_all_to_cart': 'Agregar Todo',", es_add)

# Add missing keys to ZH
zh_add = """    'add_all_to_cart': '???????',
    'my_cart': '?????',
    'total': '??:',
    'start_shopping': '????',
    'your_cart_is_empty': '????????',
    'hot': '??',
    'favorites': '???',
    'saved_items': '???',
    'all_items_in_stock': '????',
    'move_all_to_cart': '?????',
    'no_items_to_move': '????',
    'moved_all_to_cart': '??????!',
    'account_profile': '???????',
    'orders': '??',
    'vouchers': '???',
    'personal_info': '????',
    'personal_info_desc': '??, ??, ??',
    'my_orders_desc': '???????',
    'promos_alerts': '?????',
    'payment_methods': '????',
    'payment_methods_desc': '??4242?Visa?',
    'faq_desc': '???????',
    'sign_out_desc': '??????',"""
content = content.replace("'add_all_to_cart': '???????',", zh_add)

with codecs.open('lib/core/localization.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Dict fixed")
