USE [MaxiTransfersTestDB]
GO
/****** Object:  Table [dbo].[Beneficiaries]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Beneficiaries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LastNAme] [varchar](100) NOT NULL,
	[DoB] [datetime] NOT NULL,
	[Curp] [varchar](18) NOT NULL,
	[Ssn] [varchar](11) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Nationality] [varchar](50) NOT NULL,
	[ParticipationPercentage] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Beneficiaries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LastNAme] [varchar](100) NOT NULL,
	[DoB] [datetime] NOT NULL,
	[EmployeeNumber] [int] NOT NULL,
	[Curp] [varchar](18) NOT NULL,
	[Ssn] [varchar](11) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Nationality] [varchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Beneficiaries] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Beneficiaries]  WITH CHECK ADD  CONSTRAINT [FK_Beneficiaries_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Beneficiaries] CHECK CONSTRAINT [FK_Beneficiaries_Employees]
GO
/****** Object:  StoredProcedure [dbo].[CreateBeneficiary]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateBeneficiary]
(
	@Name varchar(50) ,
	@LastNAme varchar(100) ,
	@DoB datetime,
	@ParticipationPercentage int,
	@Curp varchar(18),
	@Ssn varchar(11) ,
	@Phone varchar(10) ,
	@Nationality varchar(50),
	@Id int output
)
AS          
Set nocount on  
Begin
	Insert into Beneficiaries (
		[Name]
		,[LastNAme]
		,[DoB]
		,[ParticipationPercentage]
		,[Curp]
		,[Ssn]
		,[Phone]
		,[Nationality]
		,[Active]
		) 
		values (
		@Name,
		@LastNAme,
		@DoB,
		@ParticipationPercentage,
		@Curp,
		@Ssn,
		@Phone,
		@Nationality,
		1
		)
	SELECT @Id = @@identity
END
GO
/****** Object:  StoredProcedure [dbo].[CreateEmployee]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateEmployee]
(
	@Name varchar(50) ,
	@LastNAme varchar(100) ,
	@DoB datetime,
	@EmployeeNumber int,
	@Curp varchar(18),
	@Ssn varchar(11) ,
	@Phone varchar(10) ,
	@Nationality varchar(50),
	@Id int output
)
AS          
Set nocount on  
Begin
	Insert into Employees (
		[Name]
		,[LastNAme]
		,[DoB]
		,[EmployeeNumber]
		,[Curp]
		,[Ssn]
		,[Phone]
		,[Nationality]
		,[Active]
		) 
		values (
		@Name,
		@LastNAme,
		@DoB,
		@EmployeeNumber,
		@Curp,
		@Ssn,
		@Phone,
		@Nationality,
		1
		)
	SELECT @Id = @@identity
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteBeneficiaries]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteBeneficiaries]
(
	@Id int,
	@IdUpdated int output
)
AS          
Set nocount on  
Begin
	update Beneficiary set
		[Active] = 0
		WHERE Id = @Id

		Select @IdUpdated = @Id
	
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmployee]
(
	@Id int,
	@IdUpdated int output
)
AS          
Set nocount on  
Begin
	update Employees set
		[Active] = 0
		WHERE Id = @Id

		Select @IdUpdated = @Id
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllBeneficiaries]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllBeneficiaries]
(
	@Id int 
)
AS
Begin
	SELECT 
	   [Id]
	  ,[EmployeeId]
      ,[Name]
      ,[LastNAme]
      ,[DoB]
      ,[Curp]
      ,[Ssn]
      ,[Phone]
      ,[Nationality]
	  ,[ParticipationPercentage]
  FROM [dbo].[Beneficiaries]
  WHERE [Active] = 1
  AND (@Id = 0) OR ([Id] = @Id)
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployees]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAllEmployees]
(
	@Id int 
)
AS
Begin
	SELECT 
	   [Id]
      ,[Name]
      ,[LastNAme]
      ,[DoB]
      ,[EmployeeNumber]
      ,[Curp]
      ,[Ssn]
      ,[Phone]
      ,[Nationality]
  FROM [dbo].[Employees]
  WHERE [Active] = 1
  AND (@Id = 0) OR ([Id] = @Id)
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateBeneficiaries]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateBeneficiaries]
(
	@Id int,
	@Name varchar(50) ,
	@LastNAme varchar(100) ,
	@DoB datetime,
	@ParticipationPercentage int,
	@Curp varchar(18),
	@Ssn varchar(11) ,
	@Phone varchar(10) ,
	@Nationality varchar(50),
	@IdUpdated int output
)
AS          
Set nocount on  
Begin
	update Beneficiaries set
		 [Name] = @Name
		,[LastNAme] = @LastNAme
		,[DoB] = @DoB
		,[ParticipationPercentage] = @ParticipationPercentage
		,[Curp] = @Curp
		,[Ssn] = @Ssn
		,[Phone] = @Phone
		,[Nationality] = @Nationality
		WHERE Id = @Id

		Select @IdUpdated = @Id 
	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 30/12/2021 10:09:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEmployee]
(
	@Id int,
	@Name varchar(50) ,
	@LastNAme varchar(100) ,
	@DoB datetime,
	@EmployeeNumber int,
	@Curp varchar(18),
	@Ssn varchar(11) ,
	@Phone varchar(10) ,
	@Nationality varchar(50),
	@IdUpdated int output
)
AS          
Set nocount on  
Begin
	update Employees set
		 [Name] = @Name
		,[LastNAme] = @LastNAme
		,[DoB] = @DoB
		,[EmployeeNumber] = @EmployeeNumber
		,[Curp] = @Curp
		,[Ssn] = @Ssn
		,[Phone] = @Phone
		,[Nationality] = @Nationality
		WHERE Id = @Id

		Select @IdUpdated = @Id 
	
END
GO
