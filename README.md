# Flutter + PHP CRUD 
Very simple and straightforward example of CRUD(Create, Read, Update, Delete) using Flutter & PHP

[![paypal](https://img.shields.io/badge/paypal-donate-green.svg)](http://paypal.me/jjquiazon)

# Prerequisite
1. Install any apache + php + mysql stack (XAMPP, LAMP, WAMP Stack, etc...)
2. Flutter installation. https://flutter.dev/docs/get-started/install

# Setup
1. Import school.db in your database
2. Run in git bash
    ```bash
    # This will create db.php and mobile_app/lib/env.dart files
    ./setup.sh 
    ```
3. Update db.php with you database credentials
4. Update lib/env.dart with your IPV4 Address

# Installation
```bash
# Clone this repo under PHP's htdocs
git clone https://github.com/jioo/flutter-php-crud.git
cd flutter-php-crud

# OR if your using VS Code just press F5 to run
flutter run
```
