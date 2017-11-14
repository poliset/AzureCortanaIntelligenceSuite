﻿/*
Deployment script for DataNinjago.Demo.ADFDW.DW

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DataNinjago.Demo.ADFDW.DW"
:setvar DefaultFilePrefix "DataNinjago.Demo.ADFDW.DW"
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
PRINT N'Creating [prod].[DimCustomer]...';


GO
CREATE TABLE [prod].[DimCustomer] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [prod].[DimDate]...';


GO
CREATE TABLE [prod].[DimDate] (
    [DateKey]                 INT          NOT NULL,
    [Date]                    DATETIME     NULL,
    [FullDateUK]              CHAR (10)    NULL,
    [FullDateUSA]             CHAR (10)    NULL,
    [DayOfMonth]              VARCHAR (2)  NULL,
    [DaySuffix]               VARCHAR (4)  NULL,
    [DayName]                 VARCHAR (9)  NULL,
    [DayOfWeekUSA]            CHAR (1)     NULL,
    [DayOfWeekUK]             CHAR (1)     NULL,
    [DayOfWeekInMonth]        VARCHAR (2)  NULL,
    [DayOfWeekInYear]         VARCHAR (2)  NULL,
    [DayOfQuarter]            VARCHAR (3)  NULL,
    [DayOfYear]               VARCHAR (3)  NULL,
    [WeekOfMonth]             VARCHAR (1)  NULL,
    [WeekOfQuarter]           VARCHAR (2)  NULL,
    [WeekOfYear]              VARCHAR (2)  NULL,
    [Month]                   VARCHAR (2)  NULL,
    [MonthName]               VARCHAR (9)  NULL,
    [MonthOfQuarter]          VARCHAR (2)  NULL,
    [Quarter]                 CHAR (1)     NULL,
    [QuarterName]             VARCHAR (9)  NULL,
    [Year]                    CHAR (4)     NULL,
    [YearName]                CHAR (7)     NULL,
    [MonthYear]               CHAR (10)    NULL,
    [MMYYYY]                  CHAR (6)     NULL,
    [FirstDayOfMonth]         DATE         NULL,
    [LastDayOfMonth]          DATE         NULL,
    [FirstDayOfQuarter]       DATE         NULL,
    [LastDayOfQuarter]        DATE         NULL,
    [FirstDayOfYear]          DATE         NULL,
    [LastDayOfYear]           DATE         NULL,
    [IsHolidayUSA]            BIT          NULL,
    [IsWeekday]               BIT          NULL,
    [HolidayUSA]              VARCHAR (50) NULL,
    [IsHolidayUK]             BIT          NULL,
    [HolidayUK]               VARCHAR (50) NULL,
    [FiscalDayOfYear]         VARCHAR (3)  NULL,
    [FiscalWeekOfYear]        VARCHAR (3)  NULL,
    [FiscalMonth]             VARCHAR (2)  NULL,
    [FiscalQuarter]           CHAR (1)     NULL,
    [FiscalQuarterName]       VARCHAR (9)  NULL,
    [FiscalYear]              CHAR (4)     NULL,
    [FiscalYearName]          CHAR (7)     NULL,
    [FiscalMonthYear]         CHAR (10)    NULL,
    [FiscalMMYYYY]            CHAR (6)     NULL,
    [FiscalFirstDayOfMonth]   DATE         NULL,
    [FiscalLastDayOfMonth]    DATE         NULL,
    [FiscalFirstDayOfQuarter] DATE         NULL,
    [FiscalLastDayOfQuarter]  DATE         NULL,
    [FiscalFirstDayOfYear]    DATE         NULL,
    [FiscalLastDayOfYear]     DATE         NULL,
    PRIMARY KEY CLUSTERED ([DateKey] ASC)
);


GO
PRINT N'Creating [prod].[DimMachine]...';


GO
CREATE TABLE [prod].[DimMachine] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [Condition]    VARCHAR (10)  NOT NULL,
    [CurrentRow]   BIT           NOT NULL,
    [ValidTo]      DATETIME2 (7) NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


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
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [stg].[Machine]...';


GO
CREATE TABLE [stg].[Machine] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [Code]         INT           NOT NULL,
    [Name]         VARCHAR (50)  NOT NULL,
    [Condition]    VARCHAR (10)  NOT NULL,
    [LastModified] DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [stg].[MachineCycle]...';


GO
CREATE TABLE [stg].[MachineCycle] (
    [Id]            INT           IDENTITY (1, 1) NOT NULL,
    [CycleId]       INT           NOT NULL,
    [MachineName]   VARCHAR (50)  NOT NULL,
    [CustomerName]  VARCHAR (50)  NOT NULL,
    [StartDateTime] DATETIME2 (7) NOT NULL,
    [EndDateTime]   DATETIME2 (7) NOT NULL,
    [LastModified]  DATETIME2 (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Update complete.';


GO