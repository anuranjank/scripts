#!/bin/bash
# =========================================================================
# File: check_db.sh
# Description: Checks Oracle DB status and system resources on Oracle Linux
# =========================================================================

# Set Oracle Environment Variables (Adjust these for your system)
export ORACLE_SID=rac1
export ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH

echo "=========================================="
echo "Starting Oracle DB Health Check: $(date)"
echo "=========================================="

# Check if Oracle processes are running
echo "1. Checking Oracle background processes..."
ps -ef | grep pmon | grep -v grep

if [ $? -eq 0 ]; then
    echo "SUCCESS: Oracle PMON process is active."
else
    echo "ERROR: Oracle PMON process not found!"
fi

# Run a quick query via sqlplus
echo "2. Querying Database Status via SQL*Plus..."
sqlplus -s / as sysdba << EOF
SET PAGESIZE 0 FEEDBACK OFF VERIFY OFF
SELECT 'Database Name: ' || name || ' | Open Mode: ' || open_mode FROM v\$database;
EXIT;
EOF

echo "=========================================="
echo "Execution Completed Successfully!"
echo "=========================================="