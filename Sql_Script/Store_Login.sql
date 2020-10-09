IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[Store_Login]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[Store_Login]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE Store_Login
(
	@UserName NVARCHAR(250) ,
	@Password NVARCHAR(250)
)
AS
BEGIN

SELECT AccountID, UserName, AccountTypeID
FROM dbo.Account 
WHERE UserName = @UserName AND Password = @Password

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

