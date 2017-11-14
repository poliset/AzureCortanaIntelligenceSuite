﻿/*
Deployment script for DataNinjago.Demo.ADFDW.ReferenceDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DataNinjago.Demo.ADFDW.ReferenceDB"
:setvar DefaultFilePrefix "DataNinjago.Demo.ADFDW.ReferenceDB"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

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
PRINT N'Altering [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] ALTER COLUMN [Code] VARCHAR (10) NOT NULL;


GO
PRINT N'Altering [dbo].[Machine]...';


GO
ALTER TABLE [dbo].[Machine] ALTER COLUMN [Code] VARCHAR (10) NOT NULL;


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

INSERT INTO [dbo].[Customer]
           ([Code]
           ,[Name]
           ,[LastModified])
     VALUES
           ('C0001','Customer1', '2017-11-08 21:21:30'),
		   ('C0001','Customer2', '2017-11-08 21:21:30')

INSERT INTO [dbo].[Machine]
           ([Code]
            ,[Name]
		   ,[Condition]
           ,[LastModified])
     VALUES
           ('M0001','Machine1', 'Perfect', '2017-11-08 21:21:30'),
		   ('M0001','Machine2', 'Good', '2017-11-08 21:21:30')
GO

GO
PRINT N'Update complete.';


GO
