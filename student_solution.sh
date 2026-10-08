#!/bin/bash

# SELinux Access Denial Practical
# Student Name:
# Register Number:

echo "===== SELinux Status ====="
sestatus

echo "===== Creating Web Directory ====="
mkdir -p /var/www/html/testdir

echo "===== Creating HTML File ====="
touch /var/www/html/testdir/index.html

echo "===== Setting Linux Permissions ====="
chmod 755 /var/www/html/testdir
chmod 644 /var/www/html/testdir/index.html

echo "===== Checking Initial Context ====="
ls -Zd /var/www/html/testdir
ls -Z /var/www/html/testdir/index.html

echo "===== Assigning Wrong SELinux Context ====="
chcon -t user_home_t /var/www/html/testdir/index.html

echo "===== Checking Wrong Context ====="
ls -Z /var/www/html/testdir/index.html

echo "===== Checking AVC Denials ====="
grep "denied" /var/log/audit/audit.log | tail -n 5 || ausearch -m avc -ts recent

echo "===== Correcting SELinux Context ====="
restorecon -v /var/www/html/testdir/index.html

echo "===== Checking Correct Context ====="
ls -Z /var/www/html/testdir/index.html

echo "===== Practical Completed ====="
