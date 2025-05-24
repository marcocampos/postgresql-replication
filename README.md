# PostgreSQL Replication

This project sets up a PostgreSQL replication cluster using Docker Compose. It includes a primary PostgreSQL instance and a replica instance configured for streaming replication. The setup is ideal for testing and learning about PostgreSQL replication in a containerized environment.

## Purpose

The purpose of this project is to:
- Demonstrate how to configure PostgreSQL streaming replication.
- Provide a simple and reproducible environment for testing replication features.
- Serve as a starting point for building more complex PostgreSQL clusters.

## Usage

### Prerequisites
- Docker and Docker Compose installed on your machine.
- Docker Compose version 2.4 or higher (to support health checks with `depends_on`).

### Setup Instructions
1. Clone this repository:
   ```bash
   git clone https://github.com/marcocampos/postgresql-replication.git
   cd postgresql-replication
   ```

2. Create a `.env` file to set environment variables:
   ```bash
   cp .env.example .env
   ```
   Edit the `.env` file to customize the following variables:
   - `PRIMARY_PASSWORD`: Password for the primary PostgreSQL instance.
   - `PRIMARY_USER`: Username for the primary PostgreSQL instance.
   - `PRIMARY_DB`: Database name for the primary PostgreSQL instance.
   - `REPLICA_USER`: Username for the replica PostgreSQL instance.
   - `REPLICA_PASSWORD`: Password for the replica PostgreSQL instance.
   - `REPLICATION_USER`: Username for replication.
   - `REPLICATION_PASSWORD`: Password for replication.

3. Start the cluster:
   ```bash
   docker-compose up -d
   ```

4. Verify that both containers are running:
   ```bash
   docker ps
   ```

5. Check the logs to ensure replication is working:
   ```bash
   docker logs postgres_primary
   docker logs postgres_replica
   ```

### Customization
- Modify the `docker-compose.yml` file to adjust environment variables, ports, or volumes.
- Add custom initialization scripts in the `primary-init` and `replica-init` directories.

## Notes
- This setup is for development and testing purposes only. Do not use it in production without additional security and configuration.
- Ensure the replication user (`replicator`) is properly configured in the primary instance for replication.
- Use the `.env` file to manage environment variables for easier configuration and portability.
---

Happy Hacking!
