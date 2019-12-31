-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/20/2019 20:04:41
-- Generated from EDMX file: C:\Users\King\Documents\GitHub\Models\Model1.edmx
-- --------------------------------------------------
create DATABASE [OnlineShopping]
GO

SET QUOTED_IDENTIFIER OFF;
GO
USE [OnlineShopping];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CategoryProduct_Category]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CategoryProduct] DROP CONSTRAINT [FK_CategoryProduct_Category];
GO
IF OBJECT_ID(N'[dbo].[FK_CategoryProduct_Product]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CategoryProduct] DROP CONSTRAINT [FK_CategoryProduct_Product];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products] DROP CONSTRAINT [FK_OrderProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductFeedback]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Feedbacks] DROP CONSTRAINT [FK_ProductFeedback];
GO
IF OBJECT_ID(N'[dbo].[FK_UserFeedback]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Feedbacks] DROP CONSTRAINT [FK_UserFeedback];
GO
IF OBJECT_ID(N'[dbo].[FK_UserOrder]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_UserOrder];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Categories];
GO
IF OBJECT_ID(N'[dbo].[CategoryProduct]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CategoryProduct];
GO
IF OBJECT_ID(N'[dbo].[Feedbacks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Feedbacks];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[Products]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL,
    [Username] nvarchar(max)  NOT NULL,
    [FullName] nvarchar(max)  NOT NULL,
    [ProfileImg] nvarchar(max)  NOT NULL,
    [Address] nvarchar(max)  NOT NULL,
    [PhoneNumber] nvarchar(12)  NOT NULL,
    [IsAdmin] bit  NOT NULL,
    [Active] bit  NOT NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Price] float  NOT NULL,
    [CreatedAt] datetime  NOT NULL,
    [Provider] nvarchar(max)  NOT NULL,
    [ShortDesc] nvarchar(max)  NOT NULL,
    [LongDesc] nvarchar(max)  NOT NULL,
    [Active] bit  NOT NULL,
    [OrderId] int  NOT NULL,
    [ImagePath] nvarchar(max)  NULL
);
GO

-- Creating table 'Feedbacks'
CREATE TABLE [dbo].[Feedbacks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [Content] nvarchar(max)  NOT NULL,
    [CreatedAt] datetime  NOT NULL,
    [Active] bit  NOT NULL,
    [UserId] int  NOT NULL,
    [ProductId] int  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Total] float  NOT NULL,
    [CreatedAt] datetime  NOT NULL,
    [Status] nvarchar(max)  NOT NULL,
    [UserId] int  NOT NULL
);
GO

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [CreatedAt] datetime  NOT NULL
);
GO

-- Creating table 'CategoryProduct'
CREATE TABLE [dbo].[CategoryProduct] (
    [Categories_Id] int  NOT NULL,
    [Products_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Feedbacks'
ALTER TABLE [dbo].[Feedbacks]
ADD CONSTRAINT [PK_Feedbacks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Categories_Id], [Products_Id] in table 'CategoryProduct'
ALTER TABLE [dbo].[CategoryProduct]
ADD CONSTRAINT [PK_CategoryProduct]
    PRIMARY KEY CLUSTERED ([Categories_Id], [Products_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserId] in table 'Feedbacks'
ALTER TABLE [dbo].[Feedbacks]
ADD CONSTRAINT [FK_UserFeedback]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserFeedback'
CREATE INDEX [IX_FK_UserFeedback]
ON [dbo].[Feedbacks]
    ([UserId]);
GO

-- Creating foreign key on [UserId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_UserOrder]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_UserOrder'
CREATE INDEX [IX_FK_UserOrder]
ON [dbo].[Orders]
    ([UserId]);
GO

-- Creating foreign key on [ProductId] in table 'Feedbacks'
ALTER TABLE [dbo].[Feedbacks]
ADD CONSTRAINT [FK_ProductFeedback]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductFeedback'
CREATE INDEX [IX_FK_ProductFeedback]
ON [dbo].[Feedbacks]
    ([ProductId]);
GO

-- Creating foreign key on [OrderId] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_OrderProduct]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderProduct'
CREATE INDEX [IX_FK_OrderProduct]
ON [dbo].[Products]
    ([OrderId]);
GO

-- Creating foreign key on [Categories_Id] in table 'CategoryProduct'
ALTER TABLE [dbo].[CategoryProduct]
ADD CONSTRAINT [FK_CategoryProduct_Category]
    FOREIGN KEY ([Categories_Id])
    REFERENCES [dbo].[Categories]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Products_Id] in table 'CategoryProduct'
ALTER TABLE [dbo].[CategoryProduct]
ADD CONSTRAINT [FK_CategoryProduct_Product]
    FOREIGN KEY ([Products_Id])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CategoryProduct_Product'
CREATE INDEX [IX_FK_CategoryProduct_Product]
ON [dbo].[CategoryProduct]
    ([Products_Id]);
GO


-- Insert data
insert into Users values ('duymai@yopmail.com', '123456', 'duymai', 'Duy Mai', '', '123 Bach Dang', '1234567890', 1, 1)
insert into Users values ('duymai1@yopmail.com', '123456', 'duymai1', 'Duy Maiiii', '', '123 Bach Dang', '1234567890', 0, 1)
insert into Users values ('duymai2@yopmail.com', '123456', 'duymai2', 'Not Duy Mai', '', '123 Bach Dang', '1234567890', 0, 1)
GO

insert into Categories VALUES ('Smart Phone', getDate())
insert into Categories VALUES ('Laptop', getDate())
insert into Categories VALUES ('TV', getDate())
insert into Categories VALUES ('Keyboard', getDate())
GO

insert into Orders VALUES (99.99, getDate(), 'SAVED', 1)
insert into Orders VALUES (9.99, getDate(), 'PURCHASED', 1)
insert into Orders VALUES (10.99, getDate(), 'SAVED', 1)
insert into Orders VALUES (1000, getDate(), 'PURCHASED', 2)
insert into Orders VALUES (435.5, getDate(), 'SAVED', 2)
insert into Orders VALUES (234.2, getDate(), 'PURCHASED', 2)
insert into Orders VALUES (123, getDate(), 'SAVED', 3)
insert into Orders VALUES (5345, getDate(), 'SAVED', 3)
GO

INSERT into Products VALUES ('Iphone 7', 399, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 7 of Apple', 1, 1, '')
INSERT into Products VALUES ('Iphone 5s', 99, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 7 of Apple', 1, 2, '')
INSERT into Products VALUES ('Iphone X', 799, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 7 of Apple', 1, 3, '')
INSERT into Products VALUES ('Iphone Xs Max', 1099, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 7 of Apple', 1, 4, '')
INSERT into Products VALUES ('Macbook Pro 2015', 1139, getDate(), 'Apple', 'This is a macbook pro', 'This is a macbook pro 2015 of Apple', 1, 5, '')
INSERT into Products VALUES ('iMac', 2099, getDate(), 'Apple', 'This is an iMac', 'This is an iMac of Apple', 1, 6, '')
INSERT into Products VALUES ('Magic keyboard', 199, getDate(), 'Apple', 'This is a keyboard', 'This is a keyboard of Apple', 1, 7, '')
INSERT into Products VALUES ('Airpod', 249, getDate(), 'Apple', 'This is a bluetooth earphone', 'This is a bluetooth earphone of Apple', 1, 8, '')
INSERT into Products VALUES ('Iphone 6s', 349, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 6s of Apple', 1, 2, '')
INSERT into Products VALUES ('Iphone 8 plus', 599, getDate(), 'Apple', 'This is an iphone', 'This is an iphone 8 plus of Apple', 1, 2, '')
INSERT into Products VALUES ('Magic mouse', 299, getDate(), 'Apple', 'Some desc', 'Magic mouseeee of Apple', 1, 2, '')
INSERT into Products VALUES ('Charger', 499, getDate(), 'Apple', 'Charger for macbook', 'Necessary item for macbook of Apple', 1, 4, '')
INSERT into Products VALUES ('Lenovo Thinkpad', 1099, getDate(), 'Lenovo', 'Good laptop', 'Laptop of Lenovo', 1, 4, '')
INSERT into Products VALUES ('Dell XPS', 2099, getDate(), 'Dell', 'Good laptop but expensive', 'Despite the perfect of this laptop, it is so expensive', 1, 1, '')
INSERT into Products VALUES ('Gaming keyboard', 399, getDate(), 'Razor', 'Keyboard has colors', 'Lalalaaa', 1, 2, '')
go

-- Create or alter Views --
create or ALTER VIEW Admins as
    SELECT * FROM [Users] u
        WHERE u.IsAdmin = 1
GO
-----
create or ALTER VIEW NotAdmins as
    SELECT * FROM [Users] u
        WHERE u.IsAdmin != 1
GO
-----
create or alter view AllCategories as
    SELECT * from Categories
GO
-----
create or alter view AllProducts as
    SELECT * from Products
GO

-- Create or alter Triggers --
Create or ALTER Trigger tg_CheckDuplicate on Users for insert, UPDATE as
begin
	declare @Email nvarchar(63)
	select @Email = Email
		from inserted
	if EXISTS (Select *
				From Users u
				Where u.Email = @Email)
		BEGIN
			rollback transaction
			print 'Email is already existed!'
		end
end
GO

-- Create or alter Stored Procedures --
CREATE or ALTER PROCEDURE [sp_GetProductById]
    @ProductId int = null
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    -- Insert statements for procedure here
    select *
    from Products p
    where p.Id = @ProductId
END
GO
-----
CREATE or ALTER PROCEDURE [sp_GetCategoryById]
    @CategoryId int = null
AS
BEGIN
    SET NOCOUNT ON;
    select *
    from Categories c
    where c.Id = @CategoryId
END
GO
-----
CREATE or ALTER PROCEDURE [sp_InsertCategoryInfo]
    @Name nvarchar(max),
    @CreatedAt datetime
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [Categories]
    VALUES(@Name, @CreatedAt)
END
GO
-----
CREATE or ALTER PROCEDURE [dbo].[sp_UpdateCategory]
    @CategoryId int = null,
    @Name nvarchar(max)
AS
BEGIN
    SET NOCOUNT ON;

    Update [Categories]
    set Name = @Name
    where Id = @CategoryId;

END
go
-----
CREATE or ALTER PROCEDURE [sp_DeleteCategory]
    @CategoryId int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [Categories]
    where Id = @CategoryId
END
GO

-- Create or alter Stored Functions --


-- Query Views
-- SELECT * FROM Admins
-- -----
-- SELECT * from AllCategories
-----
-- SELECT * from AllProducts
-----
-- SELECT * FROM NotAdmins

-- Call Stored Procedure
-- EXEC sp_GetProductById 8
-- EXEC sp_GetCategoryById 2
-- EXEC sp_InsertCategoryInfo 'Tablet_2', '2019-12-31 06:26:48.263'
-- EXEC sp_UpdateCategory 1, 'Smart Phone_Edited'
-- EXEC sp_DeleteCategory 6

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------