with open('android/app/src/main/AndroidManifest.xml', 'r', encoding='utf-8') as f:
    content = f.read()

if '<uses-permission android:name="android.permission.INTERNET"' not in content:
    content = content.replace('<application', '    <uses-permission android:name="android.permission.INTERNET"/>\n    <application')
    with open('android/app/src/main/AndroidManifest.xml', 'w', encoding='utf-8') as f:
        f.write(content)
