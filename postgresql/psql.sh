#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo ">>>>> usage		: psql.sh  <postgresql version>"
	echo ">>>>> example	: psql.sh  15.0"
	exit
fi

__POSTGRESQL_VERSION__=$1

echo '>>>>> [PostgreSQL] 초기화'
sudo killall apt apt-get
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt -y update
sudo apt -y upgrade
sudo timedatectl set-timezone Asia/Seoul

echo '>>>>> [PostgreSQL] 필요 패키지(gcc libreadline-dev zlib-devel) 설치'
apt-get update -y
apt-get install gcc libreadline-dev zlib-devel -y

echo ">>>>> [PostgreSQL] postgresql-${__POSTGRESQL_VERSION__}.tar.gz 다운로드 및 압축해제"
wget https://ftp.postgresql.org/pub/source/v${__POSTGRESQL_VERSION__}/postgresql-${__POSTGRESQL_VERSION__}.tar.gz
tar xvzf postgresql-${__POSTGRESQL_VERSION__}.tar.gz

echo '>>>>> [PostgreSQL] make 명령'
cd postgresql-${__POSTGRESQL_VERSION__}
./configure
make
make install
cd ..

echo '>>>>> [PostgreSQL] 계정 생성 및 sudoers 권한 부여'
useradd -s /bin/bash -d /home/postgres -m postgres
echo "postgres ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/postgres

echo '>>>>> [PostgreSQL] 데이터 디렉토리 생성 '
mkdir -p /usr/local/pgsql/data
chown postgres /usr/local/pgsql/data

echo '>>>>> [PostgreSQL] postgres db 설치(root계정 말고 postgres계정으로 수행해야 함)'
su - postgres
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data

echo '>>>>> [PostgreSQL] postgres logfile 설정'
/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile

echo '>>>>> [PostgreSQL] postgres.service 설정'
cat >> /etc/systemd/system/postgres.service <<EOF
[Unit]
Description=PostgreSQL Database
After=network.target

[Service]
Type=notify
User=postgres
Group=postgres
LimitNOFILE=65536
ExecStart=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data start
ExecStop=/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data stop
TimeoutStartSec=900
TimeoutStopSec=900
RestartSec=5s
Restart=on-success 
#on-success은 종료가 성공한 경우만 재시작함
#Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo '>>>>>  [PostgreSQL] 서비스 실행 및 자동 실행 설정'
systemctl daemon-reload
systemctl start postgres
systemctl enable postgres
