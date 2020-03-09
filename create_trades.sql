CREATE TABLE [dbo].[trades] (
id int identity primary key,
userid int not null,
[dt] datetime NOT NULL,
[ticker] varchar(20) NOT NULL,
[amount] int NOT NULL,
[price] money NOT NULL
)