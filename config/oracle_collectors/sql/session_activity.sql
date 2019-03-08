SELECT status "STATUS", type "TYPE", COUNT(*) "COUNT"
FROM v$session GROUP BY status, type