import codecs, re

def replace_in_file(path, replacements):
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    for k, v in replacements.items():
        content = content.replace(k, v)
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)

replace_in_file('lib/screens/cart/cart_screen.dart', {
    "'My Cart'": "tr('my_cart')",
    "'Total:'": "tr('total')",
    "'Start Shopping'": "tr('start_shopping')",
    "'Your Cart is Empty'": "tr('your_cart_is_empty')",
    "'Popular Deals'": "tr('popular_deals')",
    "'Hot'": "tr('hot')",
    "'See All'": "tr('see_all')",
})

replace_in_file('lib/screens/product/favorite_screen.dart', {
    "'Favorites'": "tr('favorites')",
    "'saved items'": "tr('saved_items')",
    "'All items in stock'": "tr('all_items_in_stock')",
    "'Move All to Cart'": "tr('move_all_to_cart')",
    "'No items to move'": "tr('no_items_to_move')",
    "'Moved all to Cart!'": "tr('moved_all_to_cart')",
})

replace_in_file('lib/screens/profile/profile_screen.dart', {
    "'Account & Profile'": "tr('account_profile')",
    "'Orders'": "tr('orders')",
    "'Wishlist'": "tr('wishlist')",
    "'Vouchers'": "tr('vouchers')",
    "'Personal Info'": "tr('personal_info')",
    "'Name, Email, Phone number'": "tr('personal_info_desc')",
    "'Order history & tracking'": "tr('my_orders_desc')",
    "'Promos & status alerts'": "tr('promos_alerts')",
    "'Payment Methods'": "tr('payment_methods')",
    "'Visa ending in 4242'": "tr('payment_methods_desc')",
    "'FAQ & Customer Service'": "tr('faq_desc')",
    "'Sign out of your account'": "tr('sign_out_desc')",
})

print("Screens updated")
