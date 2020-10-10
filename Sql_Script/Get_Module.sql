IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[Get_Module]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[Get_Module]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE Get_Module
(
	@UserName NVARCHAR(250)
)
AS
BEGIN

DECLARE @IsAdmin TINYINT

SELECT TOP 1 @IsAdmin = 1 
FROM		dbo.Account T1 WITH (NOLOCK)
INNER JOIN	dbo.AccountType T2 WITH (NOLOCK)
	ON		T2.AccountTypeID = T1.AccountTypeID
WHERE		T1.UserName = @UserName AND T2.AccountTypeName = 'Admin'

IF (@IsAdmin = 1)
	BEGIN
		SELECT	ModuleID ,ModuleName, ModuleIcon
		FROM	dbo.ModuleList
	END
ELSE
	BEGIN
		SELECT		T1.ModuleID, T3.ModuleName AS ModuleName , T3.ModuleIcon AS ModuleIcon
		FROM		dbo.AccountPermission T1 WITH (NOLOCK)
		INNER JOIN	dbo.Account T2 WITH (NOLOCK)
			ON		T2.AccountID = T1.AccountID
		INNER JOIN	dbo.ModuleList T3 WITH (NOLOCK)
			ON		T3.ModuleID = T1.ModuleID
		WHERE		T2.UserName = @UserName
	END

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

