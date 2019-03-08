SELECT name, value FROM v$sysstat 
WHERE name IN ('parse count (total)', 'execute count', 'user commits', 'user rollbacks')