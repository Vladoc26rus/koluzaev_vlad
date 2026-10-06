# Инструкция для установки joomla CMS
Проект устанавливает LEMP-стек на Ubuntu и подготавливает Joomla 5.1.4 к первоначальной настройке через веб.

# Состав ролей
- `nginx` — устанавливает Nginx, задаёт пользователя `www-data`;
- `php` — устанавливает PHP 8.1, устанавливает PHP-FPM и расширения Joomla, настраивает socket `/run/php/php8.1-fpm.sock`;
- `mysql` — устанавливает MySQL и `python3-pymysql`, задаёт пароль `root`, создаёт БД `joomla` и пользователя `admin` с привилегиями `*.*:ALL`;
- `initapps` — создаёт web-root, Nginx virtual host и symlink, связывает Nginx с PHP-FPM socket;
- `joomla` — скачивает Joomla 5.1.4 и распаковывает её в `/var/www/sites/joomla` с владельцем `www-data`.

# Настройка inventory
Отредактируйте `inventory/hosts.yml` - изменить IP и SSH-пользователя.

# Проверка проекта
Установите требуемую коллекцию:
ansible-galaxy collection install -r requirements.yml

Проверка `ansible-lint`:
ansible-lint playbook.yml

Проверка синтаксиса:
ansible-playbook playbook.yml --syntax-check --vault-password-file ~/.config/ansible/joomla-vault-new.pass

# Запуск playbook
ansible-playbook playbook.yml --vault-password-file ~/.config/ansible/joomla-vault-new.pass

После выполнения будут настроены:
- `/etc/nginx/sites-available/joomla.conf`;
- `/etc/nginx/sites-enabled/joomla.conf` -> `/etc/nginx/sites-available/joomla.conf`;
- `/var/www/sites/joomla`;
- PHP-FPM 8.1 socket `/run/php/php8.1-fpm.sock`;
- MySQL database `joomla`;
- MySQL user `admin`.

## Первоначальная настройка Joomla в браузере
Откройте http://<IP_СЕРВЕРА>
1. Создайте учётную запись администратора Joomla;
2. укажите параметры БД:
   - тип БД: `MySQLi`;
   - host: `localhost`;
   - пользователь: `admin`;
   - пароль: значение `mysql_admin_password` из Vault;
   - база данных: `joomla`;
   - prefix таблиц: можно оставить автоматически сгенерированный;
3. проверьте `http://<IP_СЕРВЕРА>/`;
4. проверьте административную часть: `http://<IP_СЕРВЕРА>/administrator`.
