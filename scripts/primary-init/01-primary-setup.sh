#!/bin/env bash
set -e

psql -U postgres <<EOF
CREATE ROLE ${REPLICATION_USER} WITH REPLICATION LOGIN ENCRYPTED PASSWORD '${REPLICATION_PASSWORD}';
SELECT pg_create_physical_replication_slot('replication_slot');
EOF

cat >>"${PGDATA}/postgresql.conf" <<EOF
wal_level = replica
synchronous_commit = remote_apply
synchronous_standby_names = 'FIRST 1 (postgres_replica)'
max_wal_senders = 5
wal_keep_size = 128
hot_standby = on
max_replication_slots=10
hot_standby_feedback=on
checkpoint_timeout = 10min
checkpoint_completion_target = 0.9
EOF

echo "host replication replicator all md5" >>"${PGDATA}/pg_hba.conf"
