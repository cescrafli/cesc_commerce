import codecs, re

new_keys = {
    'EN (US)': {
        'welcome_back': 'Welcome Back',
        'sign_in_desc': 'Sign in to continue exploring top fashion & deals',
        'email_phone': 'Email or Phone Number',
        'password': 'Password',
        'remember_me': 'Remember me',
        'forgot_password': 'Forgot Password?',
        'log_in': 'Log In',
        'or_continue_with': 'OR CONTINUE WITH',
        'dont_have_account': "Don't have an account? ",
        'sign_up': 'Sign up',
        'secure_encryption': '256-bit Secure Encryption  Protected by Cescrafli',
        'please_fill_all': 'Please fill all fields',
        'login_failed': 'Login failed. Check credentials.',
        'create_account': 'Create Account',
        'join_desc': 'Join Cescrafli to unlock exclusive deals and personalized fashion.',
        'full_name': 'Full Name',
        'email_address': 'Email Address',
        'phone_number': 'Phone Number',
        'terms_privacy': 'Terms & Privacy Policy',
        'already_have_account': 'Already have an account? ',
    },
    'ID (ID)': {
        'welcome_back': 'Selamat Datang',
        'sign_in_desc': 'Masuk untuk menjelajahi fashion terbaik',
        'email_phone': 'Email atau No. Telepon',
        'password': 'Kata Sandi',
        'remember_me': 'Ingat saya',
        'forgot_password': 'Lupa Kata Sandi?',
        'log_in': 'Masuk',
        'or_continue_with': 'ATAU MASUK DENGAN',
        'dont_have_account': "Belum punya akun? ",
        'sign_up': 'Daftar',
        'secure_encryption': 'Enkripsi Aman 256-bit',
        'please_fill_all': 'Mohon isi semua bidang',
        'login_failed': 'Gagal masuk. Periksa kredensial.',
        'create_account': 'Buat Akun',
        'join_desc': 'Gabung Cescrafli untuk penawaran eksklusif.',
        'full_name': 'Nama Lengkap',
        'email_address': 'Alamat Email',
        'phone_number': 'Nomor Telepon',
        'terms_privacy': 'Syarat & Kebijakan Privasi',
        'already_have_account': 'Sudah punya akun? ',
    },
    'ES (ES)': {
        'welcome_back': 'Bienvenido',
        'sign_in_desc': 'Inicie sesion para explorar la mejor moda',
        'email_phone': 'Correo o Telefono',
        'password': 'Contrasena',
        'remember_me': 'Recuerdame',
        'forgot_password': 'Olvido su contrasena?',
        'log_in': 'Iniciar Sesion',
        'or_continue_with': 'O CONTINUAR CON',
        'dont_have_account': "No tiene cuenta? ",
        'sign_up': 'Registrarse',
        'secure_encryption': 'Cifrado seguro de 256 bits',
        'please_fill_all': 'Complete todos los campos',
        'login_failed': 'Error al iniciar sesion.',
        'create_account': 'Crear Cuenta',
        'join_desc': 'Unete a Cescrafli para ofertas exclusivas.',
        'full_name': 'Nombre Completo',
        'email_address': 'Correo Electronico',
        'phone_number': 'Numero de Telefono',
        'terms_privacy': 'Terminos y Privacidad',
        'already_have_account': 'Ya tiene cuenta? ',
    },
    'ZH (CN)': {
        'welcome_back': '????',
        'sign_in_desc': '???????????',
        'email_phone': '?????',
        'password': '??',
        'remember_me': '???',
        'forgot_password': '?????',
        'log_in': '??',
        'or_continue_with': '???',
        'dont_have_account': "????? ",
        'sign_up': '??',
        'secure_encryption': '256?????',
        'please_fill_all': '???????',
        'login_failed': '????,??????',
        'create_account': '????',
        'join_desc': '??Cescrafli???????',
        'full_name': '??',
        'email_address': '????',
        'phone_number': '????',
        'terms_privacy': '?????',
        'already_have_account': '????? ',
    }
}

with codecs.open('lib/core/localization.dart', 'r', 'utf-8') as f:
    content = f.read()

for lang_code, keys in new_keys.items():
    insert_str = ""
    for k, v in keys.items():
        insert_str += f"    '{k}': '{v}',\n"
    # Find the end of the dictionary for this language
    # 'EN (US)': { ... },
    match = re.search(f"'{re.escape(lang_code)}':\s*{{(.*?)\n  }},", content, re.DOTALL)
    if match:
        old_block = match.group(0)
        # remove the last "  },"
        old_block = old_block[:-5]
        new_block = old_block + "\n" + insert_str + "  },"
        content = content.replace(match.group(0), new_block)

with codecs.open('lib/core/localization.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Dict appended")
