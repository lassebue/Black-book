﻿/*
Deployment script for F14I4DABH0Gr2

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "F14I4DABH0Gr2"
:setvar DefaultFilePrefix "F14I4DABH0Gr2"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Person].[FName] is being dropped, data loss could occur.

The column [dbo].[Person].[LName] is being dropped, data loss could occur.

The column [dbo].[Person].[MName] is being dropped, data loss could occur.

The column [dbo].[Person].[PersonType] is being dropped, data loss could occur.

The column [dbo].[Person].[FirstName] on table [dbo].[Person] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[Person].[SirName] on table [dbo].[Person] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Person])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Rename refactoring operation with key 4d4e32b6-faf8-43f2-aff0-2064326d4546 is skipped, element [dbo].[FK_Person_ToTable] (SqlForeignKeyConstraint) will not be renamed to [Fk_Post]';


GO
PRINT N'Dropping FK_Address_HouseOwner...';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Address_HouseOwner];


GO
PRINT N'Dropping FK_Phone_Person...';


GO
ALTER TABLE [dbo].[Phone] DROP CONSTRAINT [FK_Phone_Person];


GO
PRINT N'Starting rebuilding table [dbo].[Person]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Person] (
    [PersonID]  INT           NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [SirName]   NVARCHAR (50) NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_pk_Person] PRIMARY KEY CLUSTERED ([PersonID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Person])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Person] ([PersonID])
        SELECT   [PersonID]
        FROM     [dbo].[Person]
        ORDER BY [PersonID] ASC;
    END

DROP TABLE [dbo].[Person];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Person]', N'Person';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_pk_Person]', N'pk_Person', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[Post]...';


GO
CREATE TABLE [dbo].[Post] (
    [PostID]      INT      NOT NULL,
    [LoanDate]    DATETIME NOT NULL,
    [PaymentDate] DATETIME NULL,
    [PersonID]    INT      NOT NULL,
    [Amount]      MONEY    NOT NULL,
    CONSTRAINT [pk_Post] PRIMARY KEY CLUSTERED ([PostID] ASC)
);


GO
PRINT N'Creating fk_Post...';


GO
ALTER TABLE [dbo].[Post] WITH NOCHECK
    ADD CONSTRAINT [fk_Post] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID]) ON DELETE CASCADE ON UPDATE CASCADE;


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4d4e32b6-faf8-43f2-aff0-2064326d4546')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4d4e32b6-faf8-43f2-aff0-2064326d4546')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Post] WITH CHECK CHECK CONSTRAINT [fk_Post];


GO
PRINT N'Update complete.';


GO
