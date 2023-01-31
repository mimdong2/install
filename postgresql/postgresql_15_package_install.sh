#!/bin/bash

echo '>>>>>>>> [PostgreSQL] debian packages repository 추가'
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

echo '>>>>>>>> [PostgreSQL] debian packages repository key 추가'
sudo wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

echo '>>>>>>>> [PostgreSQL] apt install 명령어로 postgresql-15 설치'
sudo apt update && sudo apt install postgresql-15 -y
