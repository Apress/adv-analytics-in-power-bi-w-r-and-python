SELECT
	 PromotionKey
	,[PromotionName] = EnglishPromotionName
	,[DiscountPct]
	,[PromotionType] = [EnglishPromotionType]
	,[PromotionCategory] = [EnglishPromotionCategory]
	,[StartDate]
	,[EndDate]
	,[MinQty]
	,[MaxQty]
INTO [AdventureWorksDW_StarSchema].[dbo].[DimPromotion]
FROM [dbo].[DimPromotion]


SELECT
[SalesTerritoryKey]
,[SalesTerritoryRegion]
,[SalesTerritoryCountry]
,[SalesTerritoryGroup]
INTO [AdventureWorksDW_StarSchema].[dbo].[DimSalesTerritory]
FROM [dbo].[DimSalesTerritory]


SELECT
 p.[ProductKey]
,[ProductName] = p.[EnglishProductName]
,[ProductSubcategoryName] = sc.EnglishProductSubcategoryName
,[ProductCategoryName] = c.EnglishProductCategoryName
,p.StandardCost
,p.Color
,p.ListPrice
,p.SizeRange
,p.ModelName
,p.Class
,p.Style
,p.StartDate
,p.EndDate
INTO [AdventureWorksDW_StarSchema].[dbo].[DimProduct]
FROM [dbo].[DimProduct] p
	INNER JOIN [dbo].[DimProductSubcategory] sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
	INNER JOIN [dbo].[DimProductCategory] c
ON sc.ProductCategoryKey = c.ProductCategoryKey


SELECT [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      ,[PromotionKey]
      ,[SalesTerritoryKey]
      ,[OrderQuantity]
      ,[SalesAmount]
      ,[TaxAmt]
INTO [AdventureWorksDW_StarSchema].[dbo].[FactInternetSales]
FROM [dbo].[FactInternetSales]


SELECT [CustomerKey]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Suffix]
      ,[Gender]
      ,[EmailAddress]
      ,[YearlyIncome]
      ,[TotalChildren]
      ,[NumberChildrenAtHome]
      ,[Education] = [EnglishEducation]
      ,[HouseOwnerFlag]
      ,[NumberCarsOwned]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[Phone]
      ,[DateFirstPurchase]
      ,[CommuteDistance]
INTO [AdventureWorksDW_StarSchema].[dbo].[DimCustomer]
FROM [dbo].[DimCustomer]


SELECT [DateKey]
      ,[Date] = [FullDateAlternateKey]
      ,[DayNumberOfWeek]
      ,[WeekdayName] = [EnglishDayNameOfWeek]
      ,[DayNumberOfMonth]
      ,[DayNumberOfYear]
      ,[WeekNumberOfYear]
      ,[MonthName] = [EnglishMonthName]
      ,[MonthNumberOfYear]
      ,[CalendarQuarter]
      ,[CalendarYear]
      ,[CalendarSemester]
INTO [AdventureWorksDW_StarSchema].[dbo].[DimDate]
FROM [dbo].[DimDate]