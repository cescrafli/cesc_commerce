import re

with open('lib/core/localization.dart', 'r', encoding='utf-8') as f:
    content = f.read()

translations = {
    'welcome_back': '????',
    'sign_in_desc': '??????????',
    'email_phone': '????/???',
    'password': '??',
    'remember_me': '???',
    'forgot_password': '?????',
    'log_in': '??',
    'or_continue_with': '?????????',
    'dont_have_account': '??????',
    'sign_up': '??',
    'secure_encryption': '256?????'
}

for key, val in translations.items():
    # We find the specific line in ZH block
    pattern = rf"('{key}':\s*)'.*?'"
    
    # But since it's the 4th block (EN, ID, ES, ZH), we should probably only replace the ones with ??
    # A simpler way: we know they are '????' or '??'
    # Actually let's just do a string replace for those specific lines
    pass

# We will just split the file, find ZH (CN) block, and replace inside it
idx = content.find("'ZH (CN)'")
before = content[:idx]
after = content[idx:]

for key, val in translations.items():
    after = re.sub(rf"'{key}':\s*'\?+'", f"'{key}': '{val}'", after)
# also for don't have account with space
after = re.sub(r"'dont_have_account':\s*'\?+\s*'", f"'dont_have_account': '{translations['dont_have_account']} '", after)

content = before + after

with open('lib/core/localization.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed translations')
