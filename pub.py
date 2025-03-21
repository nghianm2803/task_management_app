import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

os.system("""
    flutter clean
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
""")
