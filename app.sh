#!/bin/sh 
 apt update -y
 apt istall nginx -y
 rm -f /var/www/html/*
 git clone https://github/ravi2krishna/login2418.git
