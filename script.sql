USE [master]
GO
/****** Object:  Database [Inventory]    Script Date: 20-12-2023 10:26:28 PM ******/
CREATE DATABASE [Inventory]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Inventory', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\Inventory.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Inventory_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\Inventory_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Inventory] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Inventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Inventory] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Inventory] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Inventory] SET ARITHABORT OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Inventory] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Inventory] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Inventory] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Inventory] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Inventory] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Inventory] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Inventory] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Inventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Inventory] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Inventory] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Inventory] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Inventory] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Inventory] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Inventory] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Inventory] SET RECOVERY FULL 
GO
ALTER DATABASE [Inventory] SET  MULTI_USER 
GO
ALTER DATABASE [Inventory] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Inventory] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Inventory] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Inventory] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Inventory] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Inventory] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Inventory', N'ON'
GO
ALTER DATABASE [Inventory] SET QUERY_STORE = ON
GO
ALTER DATABASE [Inventory] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Inventory]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Cid] [int] NOT NULL,
	[Cname] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Pid] [int] NOT NULL,
	[Pname] [varchar](50) NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sale]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sale](
	[Sid] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[CustomerName] [varchar](50) NULL,
	[SelectProduct] [int] NULL,
	[ProductPrice] [decimal](18, 0) NULL,
	[SaleDate] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sale]  WITH CHECK ADD  CONSTRAINT [FK_Sale_Product] FOREIGN KEY([SelectProduct])
REFERENCES [dbo].[Product] ([Pid])
GO
ALTER TABLE [dbo].[Sale] CHECK CONSTRAINT [FK_Sale_Product]
GO
/****** Object:  StoredProcedure [dbo].[Customer_Delete]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Customer_Delete](@Cid int)
As
   DELETE FROM Customer WHERE Cid = @Cid;
GO
/****** Object:  StoredProcedure [dbo].[Customer_Insert]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Customer_Insert](@Cid int,@Cname varchar(50), @Address varchar(50))
As
Insert Into Customer(Cid,Cname,Address) Values(@Cid,@Cname,@Address)
GO
/****** Object:  StoredProcedure [dbo].[Customer_Select]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Customer_Select]
    @Cid INT
AS
Begin
   SELECT Cname, Address FROM Customer WHERE Cid = @Cid;
End;
GO
/****** Object:  StoredProcedure [dbo].[Customer_Update]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Customer_Update](@Cid int, @Cname varchar(50), @Address varchar(50))
As
   Update Customer Set Cname=@Cname, Address=@Address Where Cid=@Cid;
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerList]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetCustomerList]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Select statements for procedure here
    SELECT * FROM Customer;
END
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerNameByCustomerID]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetCustomerNameByCustomerID]  
  
@customerID int  
  
As  
Begin  
select Cname from Customer where Cid=@customerID;  
  
End  
GO
/****** Object:  StoredProcedure [dbo].[GetProductList]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetProductList]
AS
Begin
Select * From Product
End
GO
/****** Object:  StoredProcedure [dbo].[GetProductPriceByProductID]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[GetProductPriceByProductID]  
  
@Pid int  
  
As  
Begin  
Select Price From Product Where Pid = @Pid
  
End  
GO
/****** Object:  StoredProcedure [dbo].[GetSaleList]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetSaleList]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Select statements for procedure here
    SELECT s.CustomerName, p.PName AS SelectProduct, s.ProductPrice, s.SaleDate
    FROM Sale s
    INNER JOIN Product p ON s.SelectProduct = p.Pid;
END
GO
/****** Object:  StoredProcedure [dbo].[Product_Delete]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Product_Delete](@Pid int)
As
   DELETE FROM Product WHERE Pid = @Pid;
GO
/****** Object:  StoredProcedure [dbo].[Product_Insert]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Product_Insert](@Pid int,@Pname varchar(50),@Price money)
As
	Insert Into Product(Pid,Pname,Price) Values(@Pid,@Pname,@Price)
GO
/****** Object:  StoredProcedure [dbo].[Product_Select]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Product_Select]
    @Pid INT
AS
Begin
   SELECT Pname, Price FROM Product WHERE Pid = @Pid;
End;
GO
/****** Object:  StoredProcedure [dbo].[Product_Update]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Product_Update](@Pid int, @Pname varchar(50), @Price decimal(18, 0))
As
   Update Product Set Pname=@Pname, Price=@Price Where Pid=@Pid;
GO
/****** Object:  StoredProcedure [dbo].[Sale_Insert]    Script Date: 20-12-2023 10:26:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Sale_Insert](@CustomerId int, @CustomerName varchar(50), @SelectProduct int, @ProductPrice money, @SaleDate datetime)
As
   Insert Into Sale (CustomerId,CustomerName, SelectProduct, ProductPrice, SaleDate) Values (@CustomerId, @CustomerName, @SelectProduct, @ProductPrice, @SaleDate)
GO
USE [master]
GO
ALTER DATABASE [Inventory] SET  READ_WRITE 
GO
