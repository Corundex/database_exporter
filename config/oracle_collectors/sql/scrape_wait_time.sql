SELECT n.wait_class, round(m.time_waited/m.INTSIZE_CSEC,3) AAS 
FROM v$waitclassmetric  m, v$system_wait_class n 
WHERE m.wait_class_id=n.wait_class_id and n.wait_class != 'Idle'