﻿/*
Deployment script for Minttulip.IoT.Analytics.DW

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Minttulip.IoT.Analytics.DW"
:setvar DefaultFilePrefix "Minttulip.IoT.Analytics.DW"
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
/*
The column [prod].[DimCustomer].[Branch] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[CustomerCode] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[CustomerName] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[Industry] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[Modified] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[TenantCode] is being dropped, data loss could occur.

The column [prod].[DimCustomer].[Code] on table [prod].[DimCustomer] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimCustomer].[LastModified] on table [prod].[DimCustomer] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimCustomer].[Name] on table [prod].[DimCustomer] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [prod].[DimCustomer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [prod].[DimMachine].[ActualServiceDate] is being dropped, data loss could occur.

The column [prod].[DimMachine].[Lat] is being dropped, data loss could occur.

The column [prod].[DimMachine].[Long] is being dropped, data loss could occur.

The column [prod].[DimMachine].[MachineCode] is being dropped, data loss could occur.

The column [prod].[DimMachine].[MachineName] is being dropped, data loss could occur.

The column [prod].[DimMachine].[ModelId] is being dropped, data loss could occur.

The column [prod].[DimMachine].[Modified] is being dropped, data loss could occur.

The column [prod].[DimMachine].[Code] on table [prod].[DimMachine] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimMachine].[Condition] on table [prod].[DimMachine] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimMachine].[CurrentRow] on table [prod].[DimMachine] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimMachine].[LastModified] on table [prod].[DimMachine] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [prod].[DimMachine].[Name] on table [prod].[DimMachine] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [prod].[DimMachine])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Starting rebuilding table [prod].[DimCustomer]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [prod].[tmp_ms_xx_DimCustomer] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [prod].[DimCustomer])
    BEGIN
        SET IDENTITY_INSERT [prod].[tmp_ms_xx_DimCustomer] ON;
        INSERT INTO [prod].[tmp_ms_xx_DimCustomer] ([Id])
        SELECT   [Id]
        FROM     [prod].[DimCustomer]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [prod].[tmp_ms_xx_DimCustomer] OFF;
    END

DROP TABLE [prod].[DimCustomer];

EXECUTE sp_rename N'[prod].[tmp_ms_xx_DimCustomer]', N'DimCustomer';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [prod].[DimMachine]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [prod].[tmp_ms_xx_DimMachine] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [Condition]    VARCHAR (10)  NOT NULL,
    [CurrentRow]   BIT           NOT NULL,
    [ValidTo]      DATETIME2 (7) NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [prod].[DimMachine])
    BEGIN
        SET IDENTITY_INSERT [prod].[tmp_ms_xx_DimMachine] ON;
        INSERT INTO [prod].[tmp_ms_xx_DimMachine] ([Id])
        SELECT   [Id]
        FROM     [prod].[DimMachine]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [prod].[tmp_ms_xx_DimMachine] OFF;
    END

DROP TABLE [prod].[DimMachine];

EXECUTE sp_rename N'[prod].[tmp_ms_xx_DimMachine]', N'DimMachine';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [prod].[FactMachineCycle]...';


GO
CREATE TABLE [prod].[FactMachineCycle] (
    [CycleId]    INT           NOT NULL,
    [MachineId]  INT           NOT NULL,
    [CustomerId] INT           NOT NULL,
    [DateKey]    INT           NOT NULL,
    [Duration]   FLOAT (53)    NOT NULL,
    [RowAdded]   DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([CycleId] ASC)
);


GO
PRINT N'Creating [stg].[Customer]...';


GO
CREATE TABLE [stg].[Customer] (
    [Id]           INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [stg].[Machine]...';


GO
CREATE TABLE [stg].[Machine] (
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [Condition]    VARCHAR (10)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Code] ASC)
);


GO
PRINT N'Creating [stg].[MachineCycle]...';


GO
CREATE TABLE [stg].[MachineCycle] (
    [CycleId]       INT           NOT NULL,
    [MachineName]   VARCHAR (50)  NOT NULL,
    [CustomerName]  VARCHAR (50)  NOT NULL,
    [StartDateTime] DATETIME2 (7) NOT NULL,
    [EndDateTime]   DATETIME2 (7) NOT NULL,
    [LastModified]  DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([CycleId] ASC)
);


GO
PRINT N'Altering [stg].[uspLoadDimMachine]...';


GO
ALTER PROC [stg].[uspLoadDimMachine] AS
BEGIN

    SET NOCOUNT ON

	INSERT INTO [prod].[DimMachine]
		([Code]
		,[Name]
		,[Condition]
		,[CurrentRow]
		,[ValidTo]
		,[LastModified]
		)
	SELECT
		 M.[Code]
		,M.[Name]
		,M.[Condition]
		,1
		,'9999-12-31'
		, GETDATE()
	FROM (
		MERGE [prod].[DimMachine] AS [Target]
			USING [stg].[Machine] AS [Source] ON Target.Code = Source.Code
		WHEN MATCHED AND Target.[Condition] <> Source.[Condition]
			 THEN UPDATE SET
				[CurrentRow] = 0
			   ,[LastModified] = GETDATE()
			   ,[ValidTo] = GETDATE()
		WHEN NOT MATCHED BY TARGET
			 THEN INSERT (
				 [Code]
				,[Name]
				,[Condition]
				,[CurrentRow]
				,[ValidTo]
				,[LastModified]
			   ) VALUES (
				 Source.Code
				,Source.Name
				,Source.Condition
				,1
				,'9999-12-31'
				,GETDATE()
			   )
		 OUTPUT $action AS Action, [Source].*
		) AS M
		WHERE M.Action = 'UPDATE' AND M.[Code]  IS NOT NULL;

END
GO
PRINT N'Update complete.';


GO
