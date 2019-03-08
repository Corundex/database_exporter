DECLARE @tmp_sp_db TABLE ([db] varchar(255) NOT NULL, database_size  INT NOT NULL, remarks varchar(2000) NULL)

INSERT INTO @tmp_sp_db EXEC sp_databases

SELECT db, database_size FROM @tmp_sp_db

