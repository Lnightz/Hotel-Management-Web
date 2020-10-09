IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[SP_DUMPPARAM]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SP_DUMPPARAM]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE sp_dumpparam (@SUName AS varchar(8000),@DumpValue AS int=0)
AS
/*
----- #DUMPPARAM VERSION# 28.06.10
----- Created By Nguyen Binh Minh
----- Created Date: 01/2005
----- Purpose: Lay thong tin cua cac doi tuong
-----@SUName: Ten dong thu tuc va tham so
-----@DumpValue:0, thay the toan bo gia tri tuong ung voi tham so, 1: Tu khai bao bien de thay the,2: Tu khai bao bien de thay the dong thoi tao ten store la DEBUG_TEST de chay debug
----- LastModified By Nguyen Binh Minh on 18/05/2006
----- Purpose: Neu co comment thi bo doan comment di khong xu ly
----- LastModified By Nguyen Binh Minh on 18/05/2006
----- Purpose: Cho xem cac table temp
----- LastModified by Tran Thi Hanh Van on 01/06/2006
----- Purpose: Cho phep xem dien giai cua Field (Unicode)
----- Modified By Nguyen Binh Minh on 21/10/2008
----- Purpose: Sua loi xem kieu nvarchar len 2 kieu du lieu
----- Modified By Nguyen Binh Minh on 12/04/2010
----- Purpose: Xem store hien thi du lieu = unicode
----- Modified By Nguyen Xuan Tien on 21/09/2012: chinh sua SELECT * thanh SELECT TOP 1 1 
*/

DECLARE @Obj_ID AS int
DECLARE @Error AS varchar(100)
DECLARE @Code AS nvarchar(4000)
DECLARE @Line AS nvarchar(4000)
DECLARE @DefinedLength AS int
DECLARE @BlankSpaceAdded AS int
DECLARE @TextLength AS int
DECLARE @AddOnLen AS int
DECLARE @Param AS varchar(8000)
DECLARE @LFCR AS varchar(2)  -- Line feed and return character
DECLARE @Pos AS int 
DECLARE @BasePos AS int 
DECLARE @SpacePos AS int 
DECLARE @CodePos AS int   -- Position of main code
DECLARE @ParamValueBasePos AS int   -- Position of param value 
DECLARE @ParamValuePos AS int   -- Position of param value
DECLARE @CommentPos AS int   -- comment text pos
DECLARE @CommentValue AS varchar(200)  -- comment text
DECLARE @ParamName AS varchar(200)
DECLARE @ParamValue AS varchar(200)
DECLARE @DeclareVar AS varchar(1000)
DECLARE @ParamLine AS varchar(8000)
DECLARE @ObjectName AS varchar(200)
DECLARE @MaxCharShow AS varchar(20)
DECLARE @CountComma AS int
DECLARE @CommaPos AS int
DECLARE @LineCount AS int
DECLARE @ObjectType AS int
DECLARE @ShowCodeOnly AS int
DECLARE @TypeName AS varchar(100)
DECLARE @DateTimeConvertValue AS DateTime
DECLARE @DebugProcedureName AS varchar(100)

DECLARE @ProcType AS int
DECLARE @ViewType AS int
DECLARE @FunctionType AS int
DECLARE @TableType AS int
DECLARE @InTempDB AS int

DECLARE @TriggerType AS int

DECLARE @strSQL AS nvarchar(4000)
SET NOCOUNT ON

SET @ProcType=0
SET @ViewType=1
SET @FunctionType=2
SET @TableType=3
SET @TriggerType=4

SET @LFCR=CHAR(13)+CHAR(10)
SET @DefinedLength=4000
SET @SUName=LTRIM(RTRIM(@SUName))
SET @SpacePos=CHARINDEX(' ',@SUName+' ')
SET @ParamLine=LTRIM(SUBSTRING(@SUName,@SpacePos,LEN(@SUName)))
SET @ParamLine=REPLACE(@ParamLine,CHAR(145),CHAR(39))
SET @ParamLine=REPLACE(@ParamLine,CHAR(146),CHAR(39))
SET @ObjectName=UPPER(SUBSTRING(@SUName,1,@SpacePos))

SET @InTempDB= CASE WHEN LEFT(@ObjectName,1)='#' THEN 1 ELSE 0 END -- In temporary database ?

IF @InTempDB=0
      SET @Obj_ID=OBJECT_ID(@ObjectName)
ELSE
      SET @Obj_ID=OBJECT_ID('TEMPDB..'+@ObjectName)

SET @DebugProcedureName='DEBUG_TEST'

IF @Obj_ID IS NULL
BEGIN
	SET @Error='Invalid object name '''+@ObjectName+''' in database '''+CASE WHEN @InTempDB=0 THEN DB_NAME() ELSE 'TEMPDB' END+''''
	RAISERROR(@Error,0,1)
	RETURN
END

IF @InTempDB=0
      SELECT TOP 1 @ObjectType=(CASE WHEN xtype ='P' THEN @ProcType 
      				WHEN xtype ='V' THEN @ViewType 
      				WHEN xtype='U' OR xtype='S' THEN @TableType 
      				WHEN xtype='TR' THEN @TriggerType
      				ELSE @FunctionType END) FROM SYSOBJECTS WITH(NOLOCK) WHERE  ID=@Obj_ID AND xtype IN ('FN', 'IF', 'TF','P','V','U','S','TR')
ELSE
      SELECT TOP 1 @ObjectType=(CASE WHEN xtype ='P' THEN @ProcType 
      				WHEN xtype ='V' THEN @ViewType 
      				WHEN xtype='U' OR xtype='S' THEN @TableType 
      				WHEN xtype='TR' THEN @TriggerType
      				ELSE @FunctionType END) FROM TEMPDB..SYSOBJECTS WITH(NOLOCK) WHERE  ID=@Obj_ID AND xtype IN ('FN', 'IF', 'TF','P','V','U','S','TR')

IF @ObjectType IS NULL
BEGIN
	SET @Error=''''+@ObjectName+''' is not an FUNCTION/VIEW/STORE PROCEDURE/TRIGGER or TABLE!'
	RAISERROR(@Error,0,1)
	RETURN
END

IF @ObjectType=@TableType
BEGIN
	DECLARE @TempName AS varchar(100)
 	DECLARE @TabColumn AS varchar(200),
		@TabType AS varchar(20),
		@TabDefaultValue AS varchar(1000),
		@TabAllowNull AS char(1),
		@TabDescription AS nvarchar(3000)		

		CREATE TABLE #SysProperties 
		(
			Name 		nvarchar(250),
			id			int,
			smallid 	smallint,
			value		nvarchar(3500)
		)											

		IF OBJECT_ID('SYSPROPERTIES') IS NOT NULL
			INSERT INTO #SysProperties
				SELECT 	Name, id, smallid, ''
				FROM 	SYSPROPERTIES
				WHERE 	ID = @Obj_ID AND name = 'MS_Description'

        IF @InTempDB=0
	      	DECLARE TableInfo_Cur CURSOR LOCAL FOR
	      		SELECT COL.Name AS [Column Name], 
	      			(CASE WHEN TYP.Name like '%char%' THEN TYP.Name +' (' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE 'n%char%' THEN 2 ELSE 1 END))) + ')'
	      				WHEN TYP.Name ='decimal' THEN TYP.Name +'(' + LTRIM(RTRIM(STR(COL.XPrec))) + ', ' + LTRIM(RTRIM(STR(COL.XScale))) + ')'
	      				ELSE TYP.Name END) AS [Data Type], 
	      			(CASE WHEN IsNullAble = 0 THEN '' ELSE 'X' END) AS [IsNull],
	      			(CASE WHEN IsNull(COM.Text, '') = '' THEN '' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
				IsNull(SP.value, '') as [Description]
			FROM SYSCOLUMNS COL  WITH(NOLOCK)
			INNER JOIN SYSOBJECTS TAB  WITH(NOLOCK) ON COL.ID = TAB.ID 
			INNER JOIN SYSTYPES TYP  WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> 'sysname'
			LEFT JOIN SYSOBJECTS TAB2  WITH(NOLOCK) ON TAB2.ID = COL.CDefault 
			LEFT JOIN SYSCOMMENTS COM  WITH(NOLOCK) ON COM.ID = TAB2.ID
			LEFT JOIN #Sysproperties SP ON SP.id = TAB.id 
										AND SP.smallid = COL.colid
			WHERE TAB.ID=@Obj_ID
			ORDER BY COL.ColOrder
        ELSE
	      	DECLARE TableInfo_Cur CURSOR LOCAL FOR
	      		SELECT COL.Name AS [Column Name], 
	      			(CASE WHEN TYP.Name like '%char%' THEN TYP.Name +' (' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE 'n%char%' THEN 2 ELSE 1 END))) + ')'
	      				WHEN TYP.Name ='decimal' THEN TYP.Name +'(' + LTRIM(RTRIM(STR(COL.XPrec))) + ', ' + LTRIM(RTRIM(STR(COL.XScale))) + ')'
	      				ELSE TYP.Name END) AS [Data Type], 
	      			(CASE WHEN IsNullAble = 0 THEN '' ELSE 'X' END)  AS [IsNull],
	      			(CASE WHEN IsNull(COM.Text, '') = '' THEN '' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
					IsNull(CAST(SP.value AS nvarchar(3000)), '') as [Description]	
				FROM TEMPDB..SYSCOLUMNS COL  WITH(NOLOCK)
				INNER JOIN TEMPDB..SYSOBJECTS TAB WITH(NOLOCK) ON COL.ID = TAB.ID 
				INNER JOIN TEMPDB..SYSTYPES TYP WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> 'sysname'
				LEFT JOIN TEMPDB..SYSOBJECTS TAB2 WITH(NOLOCK) ON TAB2.ID = COL.CDefault 
				LEFT JOIN TEMPDB..SYSCOMMENTS COM WITH(NOLOCK) ON COM.ID = TAB2.ID
				LEFT JOIN #Sysproperties SP ON SP.name = 'MS_Description' 
									AND SP.id = TAB.id 
									AND SP.smallid = COL.colid
				WHERE TAB.ID=@Obj_ID
				ORDER BY COL.ColOrder

	SET @MaxCharShow=100
	SET @TempName='##'+SUBSTRING(CAST (CONVERT(DECIMAL(17,17),RAND()) AS CHAR(19)),3,19) -- Not duplicated name
	SET @strSQL='CREATE TABLE '+@TempName+' ([Column Name] varchar(100),[Description] nvarchar(3000),[Data Type] varchar(100),[IsNull] char(1),[Default] varchar(100),
			[First Value] varchar('+@MaxCharShow+'),[Second Value] varchar('+@MaxCharShow+'),[Third Value] varchar('+@MaxCharShow+'))'
	EXEC(@strSQL)  -- Create temp table

      	IF @InTempDB=1 SET @ObjectName = 'TEMPDB..'+@ObjectName

	OPEN TableInfo_Cur
 	FETCH NEXT FROM TableInfo_Cur INTO @TabColumn,@TabType,@TabAllowNull,@TabDefaultValue,@TabDescription

 	WHILE @@FETCH_STATUS=0

 	BEGIN
		IF UPPER(@TabColumn) IN ('SELECT','PERCENT') OR @TabColumn LIKE '%[0-9#$^&*-+|!@]%'
			SET @Tabcolumn='['+@Tabcolumn+']'
 		SET @strSQL='DECLARE @Value01 AS varchar('+@MaxCharShow+'),@Value02 AS varchar('+@MaxCharShow+'),@Value03 AS varchar('+@MaxCharShow+')'+@LFCR
   SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 1 @Value01=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>1' ELSE '' END++@LFCR
            SET @strSQL=@strSQL+'
					SET @Value01=''?'''+@LFCR
            SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 2 @Value02=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>2' ELSE '' END+@LFCR
            SET @strSQL=@strSQL+'
					SET @Value02=''?'''+@LFCR
            SET @strSQL=@strSQL+CASE WHEN @TabType<>'image' THEN 
                        'SELECT TOP 1 @Value03=CONVERT (VARCHAR('+@MaxCharShow+'),'+@TabColumn+(CASE WHEN CHARINDEX('DATETIME',@TabType)=1 THEN ',121' ELSE '' END)+') FROM '+@ObjectName+'
				IF @@ROWCOUNT<>3' ELSE '' END+@LFCR
            SET @strSQL=@strSQL+'
					SET @Value03=''?'''+@LFCR
            SET @strSQL=@strSQL+'
		INSERT INTO '+@TempName+' ([Column Name],[Description],[Data Type],[IsNull],[Default],[First Value],[Second Value],[Third Value])
		VALUES ('''+@TabColumn+''',N'''+@TabDescription+''','''+@TabType+''','''+@TabAllowNull+''','''+REPLACE(@TabDefaultValue,'''', '''''')+''',@Value01,@Value02,@Value03)'
		EXEC(@strSQL)
	 	FETCH NEXT FROM TableInfo_Cur INTO @TabColumn,@TabType,@TabAllowNull,@TabDefaultValue,@TabDescription
 	END
 	EXECUTE('SELECT * FROM '+@TempName)
	EXEC('DROP TABLE '+@TempName)
	RETURN
END

SET @TypeName=(CASE @ObjectType WHEN @ProcType THEN 'Procedure' WHEN @ViewType THEN 'View' WHEN @FunctionType THEN 'Function' WHEN @TriggerType THEN 'Trigger' END)
SET @ShowCodeOnly=(CASE WHEN (@ParamLine='' AND @DumpValue=0) OR @ObjectType=@ViewType THEN 1 ELSE 0 END)  -- Chi xem code, khong tu dong xu ly code

-- Build code into lines
CREATE TABLE #CodeLine  -- line by line
(LineId int ,Text  nvarchar(4000) collate database_default)

DECLARE Code_Cur CURSOR LOCAL FOR
	SELECT text FROM SYSCOMMENTS WHERE ID=@Obj_ID AND Encrypted=0
	ORDER BY Number,Colid FOR READ ONLY
OPEN Code_Cur

SET @BlankSpaceAdded = 0 /*Keeps track of blank spaces at end of lines. Note Len function ignores
                             trailing blank spaces*/
SET @LineCount=0
FETCH NEXT FROM Code_Cur INTO @Code
WHILE @@FETCH_STATUS >= 0
BEGIN
	SET  @BasePos    = 1
	SET  @Pos = 1
	SET  @TextLength = LEN(@Code)
	
	WHILE @Pos  != 0
	BEGIN
		--Looking for end of line followed by carriage return
		SET @Pos =   CHARINDEX(@LFCR, @Code, @BasePos)
		
		--If carriage return found
		IF @Pos != 0
		BEGIN
			/*If new value for @Lines length will be > then the
			**set length then insert current contents of @line
			**and proceed.
			*/
			WHILE (IsNull(LEN(@Line),0) + @BlankSpaceAdded + @Pos-@BasePos + LEN(@LFCR)) > @DefinedLength
			BEGIN
				SET @AddOnLen = @DefinedLength-(IsNull(LEN(@Line),0) + @BlankSpaceAdded)
				INSERT #CodeLine VALUES
				( @LineCount,IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @AddOnLen), N''))
				SELECT @Line = NULL, @LineCount = @LineCount + 1,@BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
			END
			SET @Line = IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @Pos-@BasePos + LEN(@LFCR)), N'')
			SET @BasePos = @Pos+2
			INSERT #CodeLine VALUES( @LineCount, @Line )
			SET @LineCount = @LineCount + 1
			SET @Line = NULL
		END
		ELSE
			--else carriage return not found
			BEGIN
				IF @BasePos <= @TextLength
				BEGIN
				/*If new value for @Lines length will be > then the
				**defined length
				*/
					WHILE (IsNull(LEN(@Line),0) + @BlankSpaceAdded + @TextLength-@BasePos+1 ) > @DefinedLength
					BEGIN
						SET @AddOnLen = @DefinedLength - (IsNull(LEN(@Line),0) + @BlankSpaceAdded)
						INSERT #CodeLine VALUES
						( @LineCount,
						IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @AddOnLen), N''))
						SELECT @Line = NULL, @LineCount = @LineCount + 1,@BasePos = @BasePos + @AddOnLen, @BlankSpaceAdded = 0
					END
					SET @Line = IsNull(@Line, N'') + IsNull(SUBSTRING(@Code, @BasePos, @TextLength-@BasePos+1 ), N'')
					IF LEN(@Line) < @DefinedLength and charindex(' ', @Code, @TextLength+1 ) > 0
						SELECT @Line = @Line + ' ', @BlankSpaceAdded = 1
				END
			END
	END	
	FETCH NEXT FROM Code_Cur into @Code
END

IF @Line is NOT NULL
	INSERT #CodeLine VALUES( @LineCount, @Line )

IF @LineCount=0 -- no line return
BEGIN
	SET @Error=@TypeName+' '''+@ObjectName+''' has contains no line!'
	RAISERROR(@Error,0,1)
END

-- Out for process
DECLARE Code_Line CURSOR  LOCAL FOR
	SELECT text FROM #CodeLine ORDER BY LineID 
	FOR READ ONLY
OPEN Code_Line

IF @DumpValue=2 -- Create procedure for debugger
BEGIN
	SET @strSQL='IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N''[DBO].['+@DebugProcedureName+']'') AND '
	SET @strSQL= @strSQL+'OBJECTPROPERTY(ID, N''IsProcedure'') = 1)'  -- Is Procedure
	SET @strSQL=@strSQL+@LFCR+'DROP PROCEDURE [DBO].['+@DebugProcedureName+']'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER ON'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	SET  @strSQL=@strSQL+@LFCR+'---------------- SP_Dumpparam procedure generator for DEBUG'
	SET  @strSQL=@strSQL+@LFCR+'CREATE PROCEDURE ['+@DebugProcedureName+']'
	SET  @strSQL=@strSQL+@LFCR+'AS'
	PRINT @strSQL 
END

IF @ShowCodeOnly=1 
BEGIN
	SET @strSQL='IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N''[DBO].['+@ObjectName+']'') AND '
	IF @ObjectType=@ProcType
		SET @strSQL= @strSQL+'OBJECTPROPERTY(ID, N''IsProcedure'') = 1)'  -- Is Procedure
	IF @ObjectType=@ViewType
		SET @strSQL=@strSQL+'OBJECTPROPERTY(ID, N''IsView'') = 1)'  -- Is View
	IF @ObjectType=@FunctionType
		SET @strSQL=@strSQL+'XTYPE IN (N''FN'', N''IF'', N''TF''))' -- Is Function
	IF @ObjectType=@TriggerType
		SET @strSQL=@strSQL+'OBJECTPROPERTY(ID, N''IsTrigger'') = 1)'  -- Is Trigger

	SET @strSQL=@strSQL+@LFCR+'DROP '+UPPER(@TypeName)+' [DBO].['+@ObjectName+']'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER ON'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	IF @ObjectType IN (@ProcType,@ViewType,@FunctionType,@TriggerType)
		PRINT @strSQL 
	GOTO lbShowCodeOnly  --- Ignore all when show code only
END

FETCH NEXT FROM Code_Line INTO @Code
WHILE (@@Fetch_Status=0)  -- Find first param macth, it means after define procedure line
BEGIN
	SET @Code=REPLACE(@Code,CHAR(9),' ')  -- convert tab to space
	SET @BasePos=CHARINDEX('CREATE ' ,@Code)  -- Defintion
      IF @BasePos>0
      BEGIN
           IF CHARINDEX(@TypeName,LTRIM(SUBSTRING(@Code,@BasePos+LEN('CREATE '),LEN(@Code)))) =1  -- Is first definition  ?
      		BREAK
      END
	FETCH NEXT FROM Code_Line INTO @Code
END

-- Process to find params
CREATE TABLE #Param  -- params table
(DeclareVar varchar(1000),Name varchar(200),Value varchar(1000),Comment varchar(200) COLLATE database_default)
SET @CodePos=0 
SET @ParamValueBasePos=0
SET @BasePos = 0
WHILE (@@Fetch_Status=0)
BEGIN
	SET @Code=REPLACE(@Code,CHAR(9),' ')  -- convert tab to space
	SET @CommentPos=CHARINDEX('--',@Code,@BasePos) -- comment
      IF @CommentPos>0 
            SET @Code=LEFT(@Code, @CommentPos-1)
	SET @Pos=CHARINDEX('@',@Code,@BasePos)
	WHILE @Pos>0 
	BEGIN
		SET @CodePos=CHARINDEX('AS',@Code,@BasePos)  -- Is code position ?
		SET @SpacePos=CHARINDEX(' ',@Code+' ',@Pos)
		IF (@CodePos=0) OR (@CodePos>@Pos)
		BEGIN
			SET @ParamValuePos=CHARINDEX(',',@ParamLine+',',@ParamValueBasePos)
			SET @ParamName=LTRIM(RTRIM(SUBSTRING(@Code,@Pos,@SpacePos-@Pos)))
			SET @BasePos=CHARINDEX(',',@Code,@SpacePos)
			---- Test comma in string  ?
			SET @CountComma=0
			SET @CommaPos=CHARINDEX('''',@ParamLine,@ParamValueBasePos)
lbTestComma:
			WHILE @CommaPos<@ParamValuePos AND @CommaPos>0
			BEGIN
				SET @CountComma=@CountComma+1
				SET @CommaPos=CHARINDEX('''',@ParamLine,@CommaPos+1)
			END
			IF @CountComma%2>0   -- comma in string, find next position
			BEGIN
				SET @ParamValuePos=CHARINDEX(',',@ParamLine+',',@ParamValuePos+1)
				GOTO lbTestComma -- continue for testing
			END
			IF @ParamValuePos>0
			BEGIN					
				SET @CommentPos=CHARINDEX('--',@Code,@Pos)
				SET @DeclareVar=RTRIM(SUBSTRING(@Code,@Pos,(CASE WHEN @BasePos=0 THEN 
												(CASE WHEN @CommentPos>0 AND @CommentPos<@ParamValuePos THEN @CommentPos ELSE  LEN(@Code)+1 END)
											       ELSE @BasePos END)-@Pos))				
				SET @ParamValue=SUBSTRING(@ParamLine,@ParamValueBasePos,@ParamValuePos-@ParamValueBasePos)
				IF CHARINDEX(' DATETIME',@DeclareVar)>0  AND LTRIM(RTRIM(@ParamValue))<>'NULL'-- Date time value ?
				BEGIN					
					SET @ParamValue=CONVERT(VARCHAR(50),CAST(REPLACE(@ParamValue,'''','') AS DATETIME),121)
 					IF CHARINDEX('00:00:00.000',@ParamValue)>0  -- only date
 					BEGIN	
 						SET @ParamValue=LEFT(@ParamValue, CHARINDEX('00:00:00.000',@ParamValue)-1)
 					END
					SET @ParamValue='CAST('''+@ParamValue+''' AS DATETIME)'
				END
				IF CHARINDEX(' VARCHAR',@DeclareVar)>0 OR CHARINDEX(' CHAR',@DeclareVar)>0 
				BEGIN				
					IF CHARINDEX('''',@ParamValue)=0 AND UPPER(RTRIM(LTRIM(@ParamValue)))<>'NULL'
						SET @ParamValue=''''+@ParamValue+''''
				END
				SET @ParamValueBasePos=@ParamValuePos+1
				SET @DeclareVar=RTRIM(REPLACE(@DeclareVar,@LFCR,''))  -- Remove caterine return line feed code
				IF RIGHT(REPLACE(@DeclareVar,' ',''),2)='))'  -- Last param and end with ) ?
					SET @DeclareVar=LEFT(@DeclareVar,LEN(@DeclareVar)-1)
				INSERT INTO #Param(DeclareVar,Name,Value) VALUES (@DeclareVar,@ParamName,@ParamValue)
			END
			ELSE
			BEGIN -- param not enought ?
				SET @Error=''''+@ObjectName+''' expects parameter '+@ParamName+', which was not supplied.'
				RAISERROR(@Error,0,1)
				RETURN
			END
			IF @BasePos=0  -- last param ?
				GOTO lbParamProcess
			ELSE
				SET @Pos=CHARINDEX('@',@Code,@BasePos)
		END
		ELSE
			GOTO lbParamProcess
	END
	SET @BasePos=0
	FETCH NEXT FROM Code_Line INTO @Code
END
lbParamProcess:
-- Out for view
DECLARE Param_Line CURSOR  LOCAL SCROLL FOR
	SELECT DeclareVar,Name,Value FROM #Param
	FOR READ ONLY
OPEN Param_Line
IF @DumpValue=0
	PRINT  '/* ------------------------------------------------------------------------------------------------------------------------------------'
FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue
WHILE (@@Fetch_Status=0)
BEGIN
	IF LEN(@DeclareVar)+LEN(@ParamName)+LEN(@ParamValue)>80 -- Line too long
	BEGIN
		PRINT 'DECLARE '+@DeclareVar
		PRINT '     SET '+@ParamName+'='+@ParamValue
	END
	ELSE
		PRINT 'DECLARE '+@DeclareVar+'  SET '+@ParamName+'='+@ParamValue
	FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue
END
IF @DumpValue=0
	PRINT  ' ------------------------------------------------------------------------------------------------------------------------------------*/'
-- Is definition line of procedure ?
FETCH  FROM Code_Line INTO @Code
WHILE (@@Fetch_Status=0) AND CHARINDEX('AS',LTRIM(@Code))<>1 
BEGIN
	FETCH NEXT FROM Code_Line INTO @Code
END

lbShowCodeOnly: --- Ignore all for show code

FETCH NEXT FROM Code_Line INTO @Code   -- Ignore definition of procedure
WHILE (@@Fetch_Status=0)
BEGIN
	IF @DumpValue=0 AND @ShowCodeOnly=0
	BEGIN
		FETCH FIRST FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue  ----Fill param with param value
		WHILE (@@Fetch_Status=0)  -- process line by line
		BEGIN
			SET @BasePos=0
			SET @Pos=CHARINDEX(@ParamName,@Code,@BasePos)  -- Find param in code
			WHILE (@Pos>0)  -- Replace all param with param value
			BEGIN
				IF CHARINDEX(SUBSTRING(@Code+' ',@Pos+LEN(@ParamName),1) ,' ,=()<>+-* /%#@|\^'+CHAR(9)+CHAR(10)+CHAR(13))>0  -- Param must be seperated by ,=()<>+-*/(TAB)(CRLF)
				BEGIN
					SET @Code=STUFF (@Code,@Pos,LEN(@ParamName),@ParamValue) -- Replace
					SET @BasePos=@Pos+LEN(@ParamValue)
				END
				ELSE 
					SET @BasePos=@Pos+1 -- next value
				SET @Pos=CHARINDEX(@ParamName,@Code,@BasePos)
			END
			FETCH NEXT FROM Param_Line INTO @DeclareVar,@ParamName,@ParamValue  ----continue next line
		END
	END
	PRINT @Code  -- Show code in Result Text Window
	FETCH NEXT FROM Code_Line INTO @Code
END

IF @ShowCodeOnly=1 -- End declare
BEGIN
	SET @strSQL=@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET QUOTED_IDENTIFIER OFF'
	SET @strSQL=@strSQL+@LFCR+'GO'
	SET @strSQL=@strSQL+@LFCR+'SET ANSI_NULLS ON'
	SET @strSQL=@strSQL+@LFCR+'GO'+@LFCR+@LFCR
	IF @ObjectType IN (@ProcType,@ViewType,@FunctionType,@TriggerType)
		PRINT @strSQL 
END









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

