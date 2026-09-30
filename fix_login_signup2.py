import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

in_login = False
in_signup = False

for i in range(len(lines)):
    line = lines[i]
    if "class LoginScreen extends" in line:
        in_login = True
    elif "class SignUpScreen extends" in line:
        in_login = False
        in_signup = True
    elif "class ForgotPasswordScreen extends" in line:
        in_signup = False
    
    if in_login and "const SizedBox(height: 15)," in line and "Row(" in lines[i+1]:
        # This is the end of login
        # We will inject a SizedBox(height: 60) right before the end of the children array
        pass
        
    if in_login and "256-bit Secure Encryption" in line:
        lines[i] = line + "                const SizedBox(height: 60),\n"
        
    if in_signup and "Already have an account?" in line:
        # We can add padding after the row finishes. Wait, better to find the end of the row.
        pass

# Let's just find the exact text we want to replace globally
