# Konfigurasi password root
ROOT_PASSWORD="password_anda"

# Jalankan MariaDB jika belum berjalan
service mysql-server status > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Memulai layanan MariaDB..."
    service mysql-server start
fi

# Menyiapkan perintah SQL untuk konfigurasi otomatis
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"\r\"

expect \"Set root password?\"
send \"Y\r\"

expect \"New password:\"
send \"$ROOT_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$ROOT_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"Y\r\"

expect \"Disallow root login remotely?\"
send \"Y\r\"

expect \"Remove test database and access to it?\"
send \"Y\r\"

expect \"Reload privilege tables now?\"
send \"Y\r\"

expect eof
")

# Jalankan konfigurasi
echo "Mengamankan instalasi MariaDB..."
echo "$SECURE_MYSQL"

echo "Konfigurasi selesai. Password root MariaDB telah diatur."