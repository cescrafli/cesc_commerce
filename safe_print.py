with open('lib/core/localization.dart', 'r', encoding='utf-8') as f:
    for i, l in enumerate(f.readlines()[390:420]):
        print(f'{i+390}: {l.rstrip().encode("ascii", errors="backslashreplace").decode("ascii")}')
