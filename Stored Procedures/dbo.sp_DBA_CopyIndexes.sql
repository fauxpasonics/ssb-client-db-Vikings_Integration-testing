SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_DBA_CopyIndexes]
@SrcSchemaName NVARCHAR(100)
, @SrcTableName NVARCHAR(256)
, @TargetSchemaName NVARCHAR(100) = ''
, @TargetTableName NVARCHAR(100) = ''
, @DisplayOnly BIT = 0
AS
-- Exec dbo.sp_CopyIndexes @SrcSchemaName = 'rpt', @SrcTableName = 'DimCustomer_Live', @TargetSchemaName = 'rpt', @TargetTableName = 'DimCustomer_Stage', @DisplayOnly = 0
--DECLARE @TargetSchemaName VARCHAR(100), @TargetTableName VARCHAR(100)
declare @IndexName NVARCHAR(256)
declare @ColumnName NVARCHAR(100)
declare @is_unique NVARCHAR(100)
declare @IndexTypeDesc NVARCHAR(100)
declare @FileGroupName NVARCHAR(100)
declare @is_disabled NVARCHAR(100)
declare @IndexOptions varchar(max)
declare @IndexColumnId int
declare @IsDescendingKey int 
declare @IsIncludedColumn int
declare @TSQLScripCreationIndex NVARCHAR(max)
declare @TSQLScripDisableIndex NVARCHAR(max)

declare CursorIndex cursor for
 select schema_name(t.schema_id) [schema_name], t.name, ix.name,
 case when ix.is_unique = 1 then 'UNIQUE ' else '' END 
 , ix.type_desc,
 case when ix.is_padded=1 then 'PAD_INDEX = ON, ' else 'PAD_INDEX = OFF, ' end
 + case when ix.allow_page_locks=1 then 'ALLOW_PAGE_LOCKS = ON, ' else 'ALLOW_PAGE_LOCKS = OFF, ' end
 + case when ix.allow_row_locks=1 then  'ALLOW_ROW_LOCKS = ON, ' else 'ALLOW_ROW_LOCKS = OFF, ' end
 + case when INDEXPROPERTY(t.object_id, ix.name, 'IsStatistics') = 1 then 'STATISTICS_NORECOMPUTE = ON, ' else 'STATISTICS_NORECOMPUTE = OFF, ' end
 + case when ix.ignore_dup_key=1 then 'IGNORE_DUP_KEY = ON, ' else 'IGNORE_DUP_KEY = OFF, ' end
 + 'SORT_IN_TEMPDB = OFF, FILLFACTOR =' + CAST(CASE WHEN ix.fill_factor = 0 THEN 100 ELSE ix.fill_factor END AS VARCHAR(3))  AS IndexOptions
 --, ix.[fill_factor]
 , ix.is_disabled , FILEGROUP_NAME(ix.data_space_id) FileGroupName
 from sys.tables t 
 inner join sys.indexes ix on t.object_id=ix.object_id
 where ix.type>0 and ix.is_primary_key=0 and ix.is_unique_constraint=0 and schema_name(t.schema_id)= @SrcSchemaName and t.name=@SrcTableName
 and t.is_ms_shipped=0 and t.name<>'sysdiagrams'
 order by schema_name(t.schema_id), t.name, ix.name

open CursorIndex
fetch next from CursorIndex into  @SrcSchemaName, @SrcTableName, @IndexName, @is_unique, @IndexTypeDesc, @IndexOptions,@is_disabled, @FileGroupName

while (@@fetch_status=0)
begin
 declare @IndexColumns varchar(max)
 declare @IncludedColumns varchar(max)

 set @IndexColumns=''
 set @IncludedColumns=''

 declare CursorIndexColumn cursor for 
  select col.name, ixc.is_descending_key, ixc.is_included_column
  from sys.tables tb 
  inner join sys.indexes ix on tb.object_id=ix.object_id
  inner join sys.index_columns ixc on ix.object_id=ixc.object_id and ix.index_id= ixc.index_id
  inner join sys.columns col on ixc.object_id =col.object_id  and ixc.column_id=col.column_id
  where ix.type>0 and (ix.is_primary_key=0 or ix.is_unique_constraint=0)
  and schema_name(tb.schema_id)=@SrcSchemaName and tb.name=@SrcTableName and ix.name=@IndexName
  order by ixc.index_column_id

 open CursorIndexColumn 
 fetch next from CursorIndexColumn into  @ColumnName, @IsDescendingKey, @IsIncludedColumn

 while (@@fetch_status=0)
 begin
  if @IsIncludedColumn=0 
   set @IndexColumns=@IndexColumns + @ColumnName  + case when @IsDescendingKey=1  then ' DESC, ' else  ' ASC, ' end
  else 
   set @IncludedColumns=@IncludedColumns  + @ColumnName  +', ' 

  fetch next from CursorIndexColumn into @ColumnName, @IsDescendingKey, @IsIncludedColumn
 end

 close CursorIndexColumn
 deallocate CursorIndexColumn

 set @IndexColumns = substring(@IndexColumns, 1, len(@IndexColumns)-1)
 set @IncludedColumns = case when len(@IncludedColumns) >0 then substring(@IncludedColumns, 1, len(@IncludedColumns)-1) else '' end
 --  print @IndexColumns
 --  print @IncludedColumns

 set @TSQLScripCreationIndex =''
 set @TSQLScripDisableIndex =''
 set @TSQLScripCreationIndex='CREATE '+ @is_unique  +@IndexTypeDesc + ' INDEX ' +QUOTENAME(@IndexName)+' ON ' + QUOTENAME(@TargetSchemaName) +'.'+ QUOTENAME(@TargetTableName)+ '('+@IndexColumns+') '+ 
  case when len(@IncludedColumns)>0 then CHAR(13) +'INCLUDE (' + @IncludedColumns+ ')' else '' end + CHAR(13)+'WITH (' + @IndexOptions+ ') ON ' + QUOTENAME(@FileGroupName) + ';'  

 if @is_disabled=1 
  set  @TSQLScripDisableIndex=  CHAR(13) +'ALTER INDEX ' +QUOTENAME(@IndexName) + ' ON ' + QUOTENAME(@SrcSchemaName) +'.'+ QUOTENAME(@SrcTableName) + ' DISABLE;' + CHAR(13) 


 print @TSQLScripCreationIndex
 print @TSQLScripDisableIndex

 IF (SELECT COUNT(*) FROM sys.tables t 
			INNER join sys.indexes ix on t.object_id=ix.object_id
			WHERE schema_name(t.schema_id)= @TargetSchemaName and t.name=@TargetTableName
			AND ix.name = @IndexName) = 0
BEGIN			

	IF @DisplayOnly = 0 AND LEN(ISNULL(@TSQLScripCreationIndex,'')) > 0
	BEGIN
		EXEC sp_executesql @TSQLScripCreationIndex
	END
END
ELSE
BEGIN
PRINT '****BYPASSED INDEX CREATION****'
END

 fetch next from CursorIndex into  @SrcSchemaName, @SrcTableName, @IndexName, @is_unique, @IndexTypeDesc, @IndexOptions,@is_disabled, @FileGroupName

end
close CursorIndex
deallocate CursorIndex

GO
