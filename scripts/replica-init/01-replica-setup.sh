#!/bin/bash
set -e

cat >>"${PGDATA}/postgresql.conf" <<EOF
hot_standby = on
wal_receiver_status_interval = 1s
EOF

rm -rf "${PGDATA}"/*
chmod 700 "${PGDATA}"

until pg_basebackup -h postgres_primary -D "${PGDATA}" -U "${REPLICATION_USER}" -Fp -Xs -P -R -S replication_slot; do
	echo "Waiting for primary to be ready..."
	sleep 2
done

touch "${PGDATA}/standby.signal"
