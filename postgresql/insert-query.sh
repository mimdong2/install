#!/usr/bin/env bash

echo '>>>>> [PostgreSQL] pitr_test 테이블 생성'
psql -U postgres -d postgres -c 'CREATE TABLE IF NOT EXISTS pitr_test (id SERIAL PRIMARY KEY, create_date timestamp)'

echo '>>>>> [PostgreSQL] insert query를 위한 쉘 스크립트 생성'
echo "psql -U postgres -d postgres -c 'INSERT INTO pitr_test (create_date) values (now())'" > /var/lib/postgresql/15/main/pitr_insert.sh
