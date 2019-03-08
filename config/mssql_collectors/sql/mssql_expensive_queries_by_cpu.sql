DECLARE @sp_TopN INT = 10
DECLARE @sp_PollingIncrement INT = -1
DECLARE @sp_LastPollingTime DATETIME = DATEADD(hour, @sp_PollingIncrement, GETDATE())

--Expensive Queries By avg CPU
SELECT TOP (@sp_TopN) vcOrderBy = 'AvgCPU'
	,dtCreationTime = creation_time
	,dtLastExecutionTime = last_execution_time
	,biTotalPhysicalReads = total_physical_reads
	,biTotalLogicalReads = total_logical_reads
	,biTotalLogicalWrites = total_logical_writes
	,biTotalWorkerTime = total_worker_time
	,biTotalElapsedTime = total_elapsed_time
	,biExecutionCount = execution_count
	,biAvgWorkerTime = total_worker_time / execution_count
	,biAvgLogicalReads = total_logical_reads / execution_count
	,biAvgLogicalWrites = total_logical_writes / execution_count
	,biAvgIO = (total_logical_reads + total_logical_writes) / execution_count
	,biAvgElapsedTime = total_elapsed_time / execution_count
	,xStatementText = (
		SELECT SUBSTRING(TEXT, (qs.statement_start_offset / 2) + 1, ((CASE qs.statement_end_offset WHEN - 1 THEN DATALENGTH(TEXT) ELSE qs.statement_end_offset END - qs.statement_start_offset) / 2) + 1) AS StatementText
		FROM sys.dm_exec_sql_text(qs.sql_handle)
		FOR XML PATH('')
			,TYPE
		)
	,xQueryText = (
		SELECT TEXT AS QueryText
		FROM sys.dm_exec_sql_text(qs.sql_handle)
		FOR XML PATH('')
			,TYPE
		)
	,xQueryPlan = qp.query_plan
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
WHERE last_execution_time > @sp_LastPollingTime;

