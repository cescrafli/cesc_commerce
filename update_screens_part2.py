import codecs, re

def add_to_dict(new_keys_dict):
    with codecs.open('lib/core/localization.dart', 'r', 'utf-8') as f:
        content = f.read()
    
    for lang_code, translations in new_keys_dict.items():
        # Find where to insert in the dictionary map
        # Search for language block, e.g., 'EN (US)': {
        match = re.search(f"'{lang_code}':\s*{{", content)
        if match:
            insert_pos = match.end()
            insert_str = "\n"
            for k, v in translations.items():
                insert_str += f"    '{k}': '{v}',\n"
            content = content[:insert_pos] + insert_str + content[insert_pos:]
            
    with codecs.open('lib/core/localization.dart', 'w', 'utf-8') as f:
        f.write(content)

new_dict = {
    'EN (US)': {
        'pending': 'Pending',
        'track': 'Track',
        'details': 'Details',
        'no_orders_yet': 'No orders yet.',
        'my_orders': 'My Orders',
        'main_collections': 'MAIN COLLECTIONS',
        'choose_a_category': 'Choose a Category',
        'popular_caps': 'POPULAR',
        'items_count': ' items',
        'buy_now': 'Buy Now',
        'add_to_cart': 'Add to Cart',
        'top_customer_review': 'TOP CUSTOMER REVIEW',
        'verified_buyer': 'Verified Buyer',
        'description_caps': 'DESCRIPTION',
        'size_guide': 'Size Guide',
        'select_size': 'SELECT SIZE',
        'quantity': 'Quantity',
        'settings': 'Settings',
        'default': 'Default',
    },
    'ID (ID)': {
        'pending': 'Menunggu',
        'track': 'Lacak',
        'details': 'Detail',
        'no_orders_yet': 'Belum ada pesanan.',
        'my_orders': 'Pesanan Saya',
        'main_collections': 'KOLEKSI UTAMA',
        'choose_a_category': 'Pilih Kategori',
        'popular_caps': 'POPULER',
        'items_count': ' barang',
        'buy_now': 'Beli Sekarang',
        'add_to_cart': 'Ke Keranjang',
        'top_customer_review': 'ULASAN TERBAIK',
        'verified_buyer': 'Pembeli Terverifikasi',
        'description_caps': 'DESKRIPSI',
        'size_guide': 'Panduan Ukuran',
        'select_size': 'PILIH UKURAN',
        'quantity': 'Kuantitas',
        'settings': 'Pengaturan',
        'default': 'Bawaan',
    },
    'ES (ES)': {
        'pending': 'Pendiente',
        'track': 'Rastrear',
        'details': 'Detalles',
        'no_orders_yet': 'Sin pedidos.',
        'my_orders': 'Mis Pedidos',
        'main_collections': 'COLECCIONES',
        'choose_a_category': 'Elige Categoria',
        'popular_caps': 'POPULAR',
        'items_count': ' articulos',
        'buy_now': 'Comprar Ya',
        'add_to_cart': 'Al Carrito',
        'top_customer_review': 'MEJOR RESENA',
        'verified_buyer': 'Comprador',
        'description_caps': 'DESCRIPCION',
        'size_guide': 'Guia de Tallas',
        'select_size': 'SELECCIONAR TALLA',
        'quantity': 'Cantidad',
        'settings': 'Ajustes',
        'default': 'Predeterminado',
    },
    'ZH (CN)': {
        'pending': '???',
        'track': '??',
        'details': '??',
        'no_orders_yet': '?????',
        'my_orders': '????',
        'main_collections': '????',
        'choose_a_category': '????',
        'popular_caps': '??',
        'items_count': ' ???',
        'buy_now': '????',
        'add_to_cart': '?????',
        'top_customer_review': '????',
        'verified_buyer': '?????',
        'description_caps': '????',
        'size_guide': '????',
        'select_size': '????',
        'quantity': '??',
        'settings': '??',
        'default': '??',
    }
}

add_to_dict(new_dict)

def replace_in_file(path, replacements, imports=True):
    import os
    if not os.path.exists(path): return
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
        
    if imports and "import 'package:cesc_commerce/core/localization.dart';" not in content:
        content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cesc_commerce/core/localization.dart';")
        # Ensure Scaffold is wrapped in ValueListenableBuilder if not already
        if "ValueListenableBuilder<String>" not in content:
            # this might be tricky, let's just do it manually for known screens
            pass
            
    for k, v in replacements.items():
        content = content.replace(k, v)
        
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)

replace_in_file('lib/screens/profile/my_orders_screen.dart', {
    "'My Orders'": "tr('my_orders')",
    "'Pending'": "tr('pending')",
    "'Track'": "tr('track')",
    "'Details'": "tr('details')",
    "'No orders yet.'": "tr('no_orders_yet')",
})

replace_in_file('lib/screens/product/category_list_screen.dart', {
    "'MAIN COLLECTIONS'": "tr('main_collections')",
    "'Choose a Category'": "tr('choose_a_category')",
    "'POPULAR'": "tr('popular_caps')",
    "' items'": "tr('items_count')",
})

replace_in_file('lib/screens/product/product_detail_screen.dart', {
    "'Buy Now'": "tr('buy_now')",
    "'Add to Cart'": "tr('add_to_cart')",
    "'TOP CUSTOMER REVIEW'": "tr('top_customer_review')",
    "'Verified Buyer'": "tr('verified_buyer')",
    "'DESCRIPTION'": "tr('description_caps')",
    "'Size Guide'": "tr('size_guide')",
    "'SELECT SIZE'": "tr('select_size')",
    "'Quantity'": "tr('quantity')",
})

replace_in_file('lib/screens/profile/settings_screen.dart', {
    "'Settings'": "tr('settings')",
    "'Default'": "tr('default')",
})

print("Part 2 updated")
