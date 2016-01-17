drop table [dbo].[tkADFDst]
drop table [dbo].[tkADFSrc]
drop procedure [dbo].[spOverwritetkADFDst]
drop type [dbo].[tkADFSrcType]
GO

CREATE TABLE [dbo].[tkADFDst] (
    [data] NVARCHAR (50) NULL
);

CREATE TABLE [dbo].[tkADFSrc] (
    [data] NVARCHAR (50) NULL
);

insert into [dbo].[tkADFSrc]([data]) values ('A1')
insert into [dbo].[tkADFSrc]([data]) values ('A2')
insert into [dbo].[tkADFSrc]([data]) values ('A3')
GO

CREATE TYPE [dbo].[tkADFSrcType] AS TABLE(
    [data] [nvarchar] (50)
)
GO

CREATE PROCEDURE [dbo].[spOverwritetkADFDst] 
				@tkADFDst [dbo].[tkADFSrcType] READONLY, 
				@stringData varchar(256), @date datetime2
AS
BEGIN
    --DELETE FROM [dbo].[tkADFDst] -> this can be done as a part of copy activity
    INSERT [dbo].[tkADFDst]([data])
    SELECT [data] FROM @tkADFDst
END