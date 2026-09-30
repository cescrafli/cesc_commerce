import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# For LoginScreen
old_login_end = '''                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}'''
new_login_end = '''                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}'''
content = content.replace(old_login_end, new_login_end)

# For SignUpScreen
old_signup_end = '''                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}'''
new_signup_end = '''                    ),
                  ],
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}'''
content = content.replace(old_signup_end, new_signup_end)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed Login/SignUp bottom padding!")
