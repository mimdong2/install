#!/bin/bash

echo '>>>>> [PostgreSQL] 초기화'
sudo killall apt apt-get
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt update -y
sudo timedatectl set-timezone Asia/Seoul

echo '>>>>>>>> [PostgreSQL] 의존성 패키지 설치'
wget https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgresql-15/libpq5_15.2-1.pgdg20.04%2B1_amd64.deb
sudo dpkg -i libpq5_15.2-1.pgdg20.04+1_amd64.deb
sudo apt install libllvm10 -y
sudo apt install ssl-cert -y
sudo apt install libjson-perl -y

echo '>>>>>>>> [PostgreSQL] client common 설치'
wget https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgresql-common/postgresql-client-common_247.pgdg20.04%2B1_all.deb
sudo dpkg -i postgresql-client-common_247.pgdg20.04+1_all.deb

echo '>>>>>>>> [PostgreSQL] common 설치'
wget https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgresql-common/postgresql-common_247.pgdg20.04%2B1_all.deb
sudo dpkg -i postgresql-common_247.pgdg20.04+1_all.deb

echo '>>>>>>>> [PostgreSQL] postgresql-client-15 설치'
wget https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgresql-15/postgresql-client-15_15.2-1.pgdg20.04%2B1_amd64.deb
sudo dpkg -i postgresql-client-15_15.2-1.pgdg20.04+1_amd64.deb

echo '>>>>>>>> [PostgreSQL] postgresql-15 설치'
wget https://apt.postgresql.org/pub/repos/apt/pool/main/p/postgresql-15/postgresql-15_15.2-1.pgdg20.04%2B1_amd64.deb
sudo dpkg -i postgresql-15_15.2-1.pgdg20.04+1_amd64.deb
